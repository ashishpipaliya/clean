import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:injectable/injectable.dart';
import 'package:clean/config/env.dart';

/// AES-256-CBC encryption with a random IV per operation.
/// The IV is prepended to the ciphertext (base64) so it can be recovered on decrypt.
@lazySingleton
class EncryptionService {
  late final Key _key;

  EncryptionService() {
    _key = Key.fromUtf8(_deriveKey(Env.encryptionKey));
  }

  String _deriveKey(String raw) {
    final bytes = utf8.encode(raw);
    return sha256.convert(bytes).toString().substring(0, 32);
  }

  /// Encrypts [plainText] and returns `base64(iv) + ":" + base64(ciphertext)`.
  String encrypt(String plainText) {
    final iv = IV.fromSecureRandom(16);
    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    // Store iv alongside ciphertext so we can decrypt later.
    final combined = '${iv.base64}:${encrypted.base64}';
    return combined;
  }

  /// Decrypts a value produced by [encrypt].
  String decrypt(String encryptedText) {
    final parts = encryptedText.split(':');
    if (parts.length != 2) throw ArgumentError('Invalid encrypted format');
    final iv = IV.fromBase64(parts[0]);
    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
    return encrypter.decrypt(Encrypted.fromBase64(parts[1]), iv: iv);
  }

  /// Convenience: returns raw bytes of the derived key (e.g. for Hive encryption).
  Uint8List get keyBytes => Uint8List.fromList(utf8.encode(_deriveKey(Env.encryptionKey)));
}
