import 'package:english_search/models/vocabulary.dart';
import 'package:flutter/material.dart';

class VocabularyContainer extends StatelessWidget {
  const VocabularyContainer({
    super.key,
    required this.vocabulary,
  });
  final Vocabulary vocabulary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 16,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF55C500),
          borderRadius: BorderRadius.all(
            Radius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                        Text(
              vocabulary.definition.isNotEmpty
                  ? vocabulary.definition // データがある場合
                  : 'No definitions available', // データが空の場合
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              vocabulary.examples.isNotEmpty
                  ? vocabulary.examples.join(', ') // データがある場合
                  : 'No examples available', // データが空の場合
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),

             // テキスト間の余白
            
          ],
        ),
      ),
    );
  }
}
