#!/usr/bin/env dart
// Flutter project helper scripts
// Usage: dart scripts.dart          — interactive menu
//        dart scripts.dart <cmd>    — run directly

import 'dart:io';

// ── ANSI ──────────────────────────────────────
const _r = '\x1B[0m';
const _bold = '\x1B[1m';
const _dim = '\x1B[2m';
const _green = '\x1B[32m';
const _cyan = '\x1B[36m';

// ── Menu entries ──────────────────────────────
const _entries = [
  ('gen', 'build_runner one-shot'),
  ('gen-watch', 'build_runner watch mode'),
  ('analyze', 'flutter analyze'),
  ('format', 'dart format lib/ test/'),
  ('fix', 'dart fix --apply'),
  ('l10n', 'flutter gen-l10n'),
  ('splash', 'generate native splash screen'),
  ('icons', 'generate launcher icons'),
  ('assets', 'generate splash + icons together'),
  ('build-apk', 'release APK split per ABI'),
  ('build-aab', 'release App Bundle'),
  ('build-ios', 'iOS release no codesign'),
  ('build-debug', 'debug APK'),
  ('clean', 'flutter clean + pub get'),
  ('deep-clean', 'clean + pub cache repair'),
  ('tag', 'create & push git tag → triggers CI release'),
];

// ── Terminal helpers ──────────────────────────
void _write(String s) => stdout.write(s);
void _writeln([String s = '']) => stdout.writeln(s);

/// Switch to alternate screen, hide cursor.
void _enterRaw() {
  _write('\x1B[?1049h'); // alternate screen
  _write('\x1B[?25l'); // hide cursor
  stdin.echoMode = false;
  stdin.lineMode = false;
}

/// Restore terminal.
void _exitRaw() {
  stdin.echoMode = true;
  stdin.lineMode = true;
  _write('\x1B[?25h'); // show cursor
  _write('\x1B[?1049l'); // main screen
}

void _clearScreen() => _write('\x1B[2J\x1B[H');

void _drawMenu(int selected) {
  _clearScreen();
  _writeln();
  _writeln('  ${_bold}Flutter Scripts$_r');
  _writeln();
  for (var i = 0; i < _entries.length; i++) {
    final (key, desc) = _entries[i];
    if (i == selected) {
      _writeln('  $_bold$_green▶  ${key.padRight(14)}$_r  $_cyan$desc$_r');
    } else {
      _writeln('     $_dim${key.padRight(14)}$_r  $desc');
    }
  }
  _writeln();
  _writeln('  $_dim↑↓  navigate    Enter  select    q  quit$_r');
}

// ── Interactive picker ────────────────────────
String _pickCommand() {
  _enterRaw();
  var selected = 0;

  try {
    _drawMenu(selected);

    while (true) {
      final bytes = stdin.readByteSync();

      if (bytes == 0x1B) {
        // ESC sequence
        final b2 = stdin.readByteSync();
        if (b2 == 0x5B) {
          // '['
          final b3 = stdin.readByteSync();
          if (b3 == 0x41) {
            // Up arrow
            selected = (selected - 1 + _entries.length) % _entries.length;
            _drawMenu(selected);
          } else if (b3 == 0x42) {
            // Down arrow
            selected = (selected + 1) % _entries.length;
            _drawMenu(selected);
          }
        }
      } else if (bytes == 0x6B) {
        // k
        selected = (selected - 1 + _entries.length) % _entries.length;
        _drawMenu(selected);
      } else if (bytes == 0x6A) {
        // j
        selected = (selected + 1) % _entries.length;
        _drawMenu(selected);
      } else if (bytes == 0x0A || bytes == 0x0D) {
        // Enter
        return _entries[selected].$1;
      } else if (bytes == 0x71 || bytes == 0x51) {
        // q / Q
        _exitRaw();
        _writeln('\n  Bye.');
        exit(0);
      }
    }
  } finally {
    _exitRaw();
  }
}

// ── Command runner ────────────────────────────
Future<void> _run(String cmd, List<String> args) async {
  _writeln('\n  $_bold$_green▶  $cmd$_r\n');

  switch (cmd) {
    case 'gen':
      await _exec('dart', ['run', 'build_runner', 'build', '--delete-conflicting-outputs']);
    case 'gen-watch':
      await _exec('dart', ['run', 'build_runner', 'watch', '--delete-conflicting-outputs']);
    case 'analyze':
      await _exec('flutter', ['analyze', '--no-fatal-infos']);
    case 'format':
      await _exec('dart', ['format', 'lib/', 'test/']);
    case 'fix':
      await _exec('dart', ['fix', '--apply']);
    case 'l10n':
      await _exec('flutter', ['gen-l10n']);
    case 'splash':
      await _exec('dart', ['run', 'flutter_native_splash:create']);
    case 'icons':
      await _exec('dart', ['run', 'flutter_launcher_icons']);
    case 'assets':
      await _exec('dart', ['run', 'flutter_native_splash:create']);
      await _exec('dart', ['run', 'flutter_launcher_icons']);
    case 'build-apk':
      await _exec('flutter', ['build', 'apk', '--release', '--split-per-abi']);
    case 'build-aab':
      await _exec('flutter', ['build', 'appbundle', '--release']);
    case 'build-ios':
      await _exec('flutter', ['build', 'ios', '--release', '--no-codesign']);
    case 'build-debug':
      await _exec('flutter', ['build', 'apk', '--debug']);
    case 'clean':
      await _exec('flutter', ['clean']);
      await _exec('flutter', ['pub', 'get']);
    case 'deep-clean':
      await _exec('flutter', ['clean']);
      await _exec('rm', ['-rf', '.dart_tool']);
      await _exec('flutter', ['pub', 'cache', 'repair']);
      await _exec('flutter', ['pub', 'get']);
    case 'tag':
      var version = args.isNotEmpty ? args.first : '';
      if (version.isEmpty) {
        stdout.write('  Enter version tag (e.g. v1.0.0): ');
        version = stdin.readLineSync()?.trim() ?? '';
      }
      if (version.isEmpty) {
        stderr.writeln('❌ No version provided.');
        exit(1);
      }
      await _exec('git', ['tag', version]);
      await _exec('git', ['push', 'origin', version]);
      _writeln('  ✅ Tag $version pushed — GitHub Actions will build the release.');
    default:
      stderr.writeln('❌ Unknown command: $cmd');
      exit(1);
  }
}

Future<void> _exec(String cmd, List<String> args) async {
  final result = await Process.start(
    cmd,
    args,
    mode: ProcessStartMode.inheritStdio,
  );
  final code = await result.exitCode;
  if (code != 0) exit(code);
}

// ── Entry point ───────────────────────────────
Future<void> main(List<String> arguments) async {
  if (arguments.isNotEmpty) {
    await _run(arguments.first, arguments.skip(1).toList());
  } else {
    final chosen = _pickCommand();
    _writeln('\n  $_bold$_green▶  Running: $chosen$_r\n');
    await _run(chosen, []);
  }
}
