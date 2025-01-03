import 'package:english_search/widget/vocabulary_container.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http; // httpという変数を通して、httpパッケージにアクセス
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:english_search/models/vocabulary.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Vocabulary> vocabulary = []; // 検索結果を格納する変数
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('English Search'),
      ),
      body: Column(
        children: [
          // 検索ボックス
          //TextField(),
          Padding(
            // ← Paddingで囲む
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 36,
            ),
            child: TextField(
              style: TextStyle(
                // ← TextStyleを渡す
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                // ← InputDecorationを渡す
                hintText: '検索ワードを入力してください',
              ),
              onSubmitted: (String value) async {
                final results = await searchEnglish(value);
                setState(() => vocabulary = results); // 検索結果を代入 // ← 検索処理を実行する
              },
            ),
          ),
          Expanded(
            child: ListView(
              children: vocabulary
                  .map((vocabulary) =>
                      VocabularyContainer(vocabulary: vocabulary))
                  .toList(),
            ),
          ),

          // 検索結果一覧
        ],
      ),
    );
  }
  Future<List<Vocabulary>> searchEnglish(String keyword) async {
  final uri = Uri.https('wordsapiv1.p.rapidapi.com', '/words/$keyword/', {});
  final String token = dotenv.env['English_ACCESS_TOKEN'] ?? '';

  try {
    final http.Response res = await http.get(uri, headers: {
      'X-RapidAPI-Key': token,
      'X-RapidAPI-Host': 'wordsapiv1.p.rapidapi.com',
    });

    if (res.statusCode == 200) {
      // Decode the response body
      final Map<String, dynamic> body = jsonDecode(res.body);
      debugPrint('API Response: $body');

      if (body.containsKey('results')) {
        final List<dynamic> results = body['results'];
        debugPrint('Results: $results');
        return results.map((result) => Vocabulary.fromJson(result)).toList();
      } else {
        debugPrint('No "results" found in the API response.');
        return [];
      }
    } else {
      debugPrint('API call failed with status code: ${res.statusCode}');
      return [];
    }
  } catch (e) {
    debugPrint('Error occurred: $e');
    return [];
  }
}




  void parseResponse(String responseBody) {
  final jsonResponse = json.decode(responseBody);
  debugPrint(jsonResponse);  // デバッグ用にレスポンス全体を出力

  if (jsonResponse.containsKey('results') && jsonResponse['results'].isNotEmpty) {
    final definition = jsonResponse['results'][0]['definition'] ?? "No definition available";
    debugPrint("Definition: $definition");
  } else {
    debugPrint("No definitions found in the API response.");
  }
}
String getDefinition(Map<String, dynamic> apiResponse) {
  if (apiResponse.containsKey('results') && apiResponse['results'].isNotEmpty) {
    return apiResponse['results'][0]['definition'] ?? "No definition available";
  }
  return "No definition available";
}
List<String> getDefinitions(Map<String, dynamic> apiResponse) {
  List<String> definitions = [];
  if (apiResponse.containsKey('results') && apiResponse['results'].isNotEmpty) {
    for (var result in apiResponse['results']) {
      definitions.add(result['definition'] ?? "No definition available");
    }
  }
  return definitions;
}


}
