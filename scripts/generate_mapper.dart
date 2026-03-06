// scripts/generate_mapper.dart
// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:args/args.dart';

void main(List<String> args) {
  final parser = ArgParser()
    ..addOption('model-path', abbr: 'm', help: 'Path to the Model file')
    ..addOption('entity-path', abbr: 'e', help: 'Path to the Entity file')
    ..addFlag('dry-run', abbr: 'd', help: 'Preview changes without writing');

  final results = parser.parse(args);
  final modelPath = results['model-path'] as String?;
  final entityPath = results['entity-path'] as String?;

  if (modelPath == null || entityPath == null) {
    print('Usage: dart run scripts/generate_mapper.dart --model-path <path> --entity-path <path> [--dry-run]');
    exit(1);
  }

  generateMapper(modelPath, entityPath, dryRun: results['dry-run'] as bool);
}

void generateMapper(String modelPath, String entityPath, {bool dryRun = false}) async {
  final modelFile = File(modelPath);
  final entityFile = File(entityPath);

  if (!modelFile.existsSync()) {
    print('❌ Model file not found: $modelPath');
    exit(1);
  }
  if (!entityFile.existsSync()) {
    print('❌ Entity file not found: $entityPath');
    exit(1);
  }

  final modelContent = await modelFile.readAsString();
  final entityContent = await entityFile.readAsString();

  final modelUnit = parseString(content: modelContent).unit;
  final entityUnit = parseString(content: entityContent).unit;

  // Extract model and entity info
  final modelInfo = _extractClassInfo(modelUnit);
  final entityInfo = _extractClassInfo(entityUnit);

  if (modelInfo == null || entityInfo == null) {
    print('❌ Could not extract class information');
    exit(1);
  }

  print('📖 Model: ${modelInfo.className} with ${modelInfo.fields.length} fields');
  print('📖 Entity: ${entityInfo.className} with ${entityInfo.fields.length} fields');

  // Create field mapping (model field -> entity field)
  final fieldMapping = <String, String>{};
  for (final modelField in modelInfo.fields) {
    // Try to find matching entity field by name similarity
    final entityField = entityInfo.fields.firstWhere(
      (ef) => _isSimilar(modelField, ef),
      orElse: () => modelField, // fallback to same name
    );
    fieldMapping[modelField] = entityField;
  }

  print('🔗 Field mapping:');
  fieldMapping.forEach((model, entity) {
    print('   $model → $entity');
  });

  // Generate extension file
  final extensionFileName = modelPath.replaceAll('.dart', '_mapper.dart');
  final extensionContent = _generateExtensionFile(
    modelInfo.className,
    entityInfo.className,
    fieldMapping,
    modelPath,
    entityPath,
  );

  if (dryRun) {
    print('\n🧪 DRY-RUN PREVIEW:\n');
    print('File: $extensionFileName\n');
    print(extensionContent);
    return;
  }

  final extensionFile = File(extensionFileName);
  await extensionFile.writeAsString(extensionContent);
  print('✅ Extension created: $extensionFileName');
  print('💡 Import it in your repository: import \'${extensionFileName.split('/').last}\';');
}

String _generateExtensionFile(
  String modelClassName,
  String entityClassName,
  Map<String, String> fieldMapping,
  String modelPath,
  String entityPath,
) {
  final modelImport = modelPath.replaceAll('lib/', 'package:clean/');
  final entityImport = entityPath.replaceAll('lib/', 'package:clean/');

  final toEntityMappings = fieldMapping.entries
      .map((e) => '${e.value}: ${e.key}')
      .join(',\n      ');

  final fromEntityMappings = fieldMapping.entries
      .map((e) => '${e.key}: ${e.value}')
      .join(',\n      ');

  return '''
// Generated mapper extension for $modelClassName
import '$modelImport';
import '$entityImport';

extension ${modelClassName}Mapper on $modelClassName {
  $entityClassName toEntity() => $entityClassName(
      $toEntityMappings,
    );
}

extension ${entityClassName}Mapper on $entityClassName {
  $modelClassName toModel() => $modelClassName(
      $fromEntityMappings,
    );
}
''';
}

ClassInfo? _extractClassInfo(CompilationUnit unit) {
  String? className;
  final fields = <String>[];

  unit.visitChildren(_ClassInfoExtractor(
    onClassFound: (name) => className = name,
    onFieldsFound: (f) => fields.addAll(f),
  ));

  if (className == null) return null;
  return ClassInfo(className!, fields);
}

bool _isSimilar(String modelField, String entityField) {
  // Remove common prefixes/suffixes and compare
  final normalized1 = modelField
      .replaceAll(RegExp(r'(full|email|user|data)'), '')
      .toLowerCase();
  final normalized2 = entityField
      .replaceAll(RegExp(r'(full|email|user|data)'), '')
      .toLowerCase();

  return normalized1 == normalized2 ||
      modelField.toLowerCase().contains(entityField.toLowerCase()) ||
      entityField.toLowerCase().contains(modelField.toLowerCase());
}

class ClassInfo {
  final String className;
  final List<String> fields;

  ClassInfo(this.className, this.fields);
}

class _ClassInfoExtractor extends RecursiveAstVisitor<void> {
  final Function(String)? onClassFound;
  final Function(List<String>)? onFieldsFound;
  bool _foundClass = false;

  _ClassInfoExtractor({this.onClassFound, this.onFieldsFound});

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (_foundClass) return;
    onClassFound?.call(node.name.lexeme);
    _foundClass = true;

    final fields = <String>[];

    // Extract from constructor parameters
    for (final member in node.members) {
      if (member is ConstructorDeclaration) {
        // Skip fromJson and other named constructors
        if (member.name?.lexeme == 'fromJson' || 
            member.name?.lexeme == 'fromEntity' ||
            member.name?.lexeme == 'toEntity') {
          continue;
        }
        
        for (final param in member.parameters.parameters) {
          if (param is SimpleFormalParameter) {
            final name = param.name?.lexeme ?? '';
            if (name.isNotEmpty && name != 'json') {
              fields.add(name);
            }
          } else if (param is DefaultFormalParameter) {
            final inner = param.parameter;
            if (inner is SimpleFormalParameter) {
              final name = inner.name?.lexeme ?? '';
              if (name.isNotEmpty && name != 'json') {
                fields.add(name);
              }
            }
          } else if (param is FieldFormalParameter) {
            final name = param.name.lexeme;
            if (name != 'json') {
              fields.add(name);
            }
          }
        }
      }
    }

    // Also extract from field declarations
    for (final member in node.members) {
      if (member is FieldDeclaration) {
        for (final variable in member.fields.variables) {
          final name = variable.name.lexeme;
          if (!fields.contains(name)) {
            fields.add(name);
          }
        }
      }
    }

    onFieldsFound?.call(fields);
  }
}
