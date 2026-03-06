import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {

  @EnviedField(varName: 'ENCRYPTION_KEY', obfuscate: true)
  static final String encryptionKey = _Env.encryptionKey;
}
