import 'dart:convert';

import 'package:untitled/api/certificate_service.dart';
import 'package:untitled/service/date_format.dart';

class SignatureService {
  static getCertificateInfo(
    String? username,
  ) {
    var certificateInfo = jsonEncode({
      "username": username,
      "timestamp": TimeService.timeToBackEndMaster(TimeService.getTimeNow()),
      "exp": 2799360000000
    });
    return certificateInfo;
  }

  static String getSignature(var certificateInfo, String privateKey) {
    var hashCertificateInfo = hashMessage(certificateInfo);
    var signature = signMessage(privateKey, hashCertificateInfo);
    return signature;
  }

  static String getCertificate(
      var certificateInfo, String signature, String publicKey) {
    var certificate = jsonEncode({
      "signature": signature,
      "certificateInfo": jsonDecode(certificateInfo),
      "publicKey": publicKey,
    });
    return certificate;
  }

  static List<String> getCertificateLogin(
      var certificateInfo,
      String? username,
      String? encryptedPrivateKey,
      String signature,
      String publicKey,
      String time) {
    var certificate = jsonEncode({
      "signature": signature,
      "certificateInfo": jsonDecode(certificateInfo),
      "publicKey": publicKey,
    });

    var body = jsonEncode({
      "certificateInfo": jsonDecode(certificateInfo),
      "_actionType": "POST_V1-USER-BWIT-QVZVCZHYJ4FPCPPT-CONTACTS",
      "_timestamp": time,
      "_signature": signature,
    });

    List<String> result = [];
    result.add(certificate);
    result.add(body);
    return result;
  }

  static getCertificateFinal(var certificateInfo, String signature,
      String _signature, String publicKey, String time) {
    var certificateFinal = jsonEncode({
      "signature": signature,
      "certificateInfo": jsonDecode(certificateInfo),
      "publicKey": publicKey,
      "_signature": _signature,
      "_actionType": "POST_API-AUTH-PING",
      "_timestamp": time
    });
    return certificateFinal;
  }
}
