import '../../../../main.dart';

class SecureStorage{

  static Future<Map<String, String>> returnHeader() async{
    return {
      "Content-Type": "multipart/form-data",
      "Accept": "application/json",
    "Authorization": "Bearer ${await storage.readAccessToken()}"

  };
  }

  static Future<Map<String, String>> returnHeaderWithToken() async{
    return {
      'Content-Type': 'application/json',
      "Accept": "application/json",
      "Authorization": "Bearer ${await storage.readAccessToken()}"
    };
  }

  static Future<Map<String, String>> returnHeaderWithMultipartToken() async{
    return {
      "Content-Type": "multipart/form-data",
      "Accept": "application/json",
      "Authorization": "Bearer ${await storage.readAccessToken()}"
    };
  }

}