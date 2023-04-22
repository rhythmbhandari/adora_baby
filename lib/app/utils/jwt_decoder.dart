library jwt_decoder;

import 'dart:convert';

class JwtDecoder {
  static Map<String, dynamic> decode(String token) {
    final splitToken = token.split(".");
    if (splitToken.length != 3) {
      throw const FormatException('Invalid token');
    }
    try {
      final payloadBase64 = splitToken[1];
      final normalizedPayload = base64.normalize(payloadBase64);
      final payloadString = utf8.decode(base64.decode(normalizedPayload));
      final decodedPayload = jsonDecode(payloadString);

      return decodedPayload;
    } catch (error) {
      throw const FormatException('Invalid payload');
    }
  }

  static Map<String, dynamic>? tryDecode(String token) {
    try {
      return decode(token);
    } catch (error) {
      return null;
    }
  }

  static bool isExpired(String token) {
    final expirationDate = getExpirationDate(token);
    return DateTime.now().isAfter(expirationDate);
  }

  static DateTime getExpirationDate(String token) {
    final decodedToken = decode(token);

    final expirationDate = DateTime.fromMillisecondsSinceEpoch(0)
        .add(Duration(seconds: decodedToken['exp'].toInt()));
    return expirationDate;
  }

  static Duration getTokenTime(String token) {
    final decodedToken = decode(token);

    final issuedAtDate = DateTime.fromMillisecondsSinceEpoch(0)
        .add(Duration(seconds: decodedToken["iat"]));
    return DateTime.now().difference(issuedAtDate);
  }

  static Duration getRemainingTime(String token) {
    final expirationDate = getExpirationDate(token);

    return expirationDate.difference(DateTime.now());
  }
}
