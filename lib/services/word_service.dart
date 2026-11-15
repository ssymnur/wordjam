
import 'dart:convert';
import 'package:http/http.dart' as http;

class WordService {
  Future<List<Map<String, dynamic>>> fetchWords(
      String level,
      ) async {
    final url = Uri.parse(
      'https://raw.githubusercontent.com/ssymnur/wordjam-dictionary/main/${level.toLowerCase()}.json',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Words could not be loaded!');
    }
  }
}
