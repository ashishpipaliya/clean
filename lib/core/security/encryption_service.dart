import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:injectable/injectable.dart';
import 'package:clean/config/env.dart';

@lazySingleton
class EncryptionService {
  late final Encrypter _encrypter;
  late final IV _iv;

  EncryptionService() {
    final key = Key.fromUtf8(_deriveKey(Env.encryptionKey));
    _iv = IV.fromLength(16);
    _encrypter = Encrypter(AES(key));
  }

  String _deriveKey(String key) {
    final bytes = utf8.encode(key);
    final hash = sha256.convert(bytes);
    return hash.toString().substring(0, 32);
  }

  String encrypt(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  String decrypt(String encryptedText) {
    final encrypted = Encrypted.fromBase64(encryptedText);
    return _encrypter.decrypt(encrypted, iv: _iv);
  }
}
