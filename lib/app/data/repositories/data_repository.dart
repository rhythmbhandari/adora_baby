import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../config/constants.dart';
import '../../utils/secure_storage.dart';

class DataRepository {
  // static Future<User> fetchProfileDetails() async {
  //   String url = '$BASE_URL/accounts/me';
  //   final response = await http.get(Uri.parse(url), headers: await SecureStorage.returnHeaderWithToken());
  //   print('Response is $response');
  //   var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  //   if (response.statusCode == 200) {
  //
  //     return trendingList;
  //   } else {
  //     return [];
  //   }
  // }
}