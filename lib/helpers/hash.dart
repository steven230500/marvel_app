import 'dart:convert';

import 'package:crypto/crypto.dart';

String generateMarvelHash(
    String timeStamp, String publicKey, String privateKey) {
  final input = timeStamp + privateKey + publicKey;
  final bytes = utf8.encode(input);
  final digest = md5.convert(bytes);
  return digest.toString();
}
