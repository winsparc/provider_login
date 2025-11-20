import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  
  static const String baseUrl = "http://10.229.74.113:3000";

  Future<List<dynamic>> fetchUsers() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user'),
      //   headers: {
      //   'Authorization': 'Bearer $token', // JWT Bearer token format
      //   'Content-Type': 'application/json', // Explicitly set for JSON
      // },
        
        );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print('User list fetched:');
        print(data);

        // Your API returns a LIST directly
        return data;  
      } else {
        print("Error Status: ${response.statusCode}");
        throw Exception("Failed to load users");
      }
    } catch (e) {
      print("Exception: $e");
      rethrow; // optional
    }
  }
}
