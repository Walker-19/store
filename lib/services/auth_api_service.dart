import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class AuthApiService {
  // authentification
  Future<Map<String, dynamic>> getAuth(Map loginType) async {
    // url de l'API
    Uri url = Uri.parse('https://api.escuelajs.co/api/v1/auth/login');

    // requête/réponse HTTP
    http.Response response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginType),
    );

    // inspect(response);

    // tester le statut 200 et 201
    if ([200, 201].contains(response.statusCode)) {
      // décoder les données en JSON
      Map<String, dynamic> data = jsonDecode(response.body);

      return data;
    }

    // renvoyer une erreur
    throw Error();
  }
}
