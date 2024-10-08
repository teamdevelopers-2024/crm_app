import 'dart:convert';

import 'package:http/http.dart' as http;


class AuthServices {
  Future<bool> login({required String userId, required String password}) async {
    try {
      final uri = Uri.parse("http://your-api-url.com/api/login");

      // Make HTTP POST request
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'password': password,
        }),
      );

      // Check if the status code is 200 (success)
      if (response.statusCode == 200) {
        // Parse the JSON response
        final responseData = jsonDecode(response.body);

        // Assuming the API returns a success flag
        return responseData['success'] == true;
      } else {
        // Log the error for debugging or monitoring
        print('Login failed. Status code: ${response.statusCode}');
        return false;
      }
    } catch (error) {
      // Catch network or JSON parsing errors
      print('Error occurred during login: $error');
      return false;
    }
  }
}
