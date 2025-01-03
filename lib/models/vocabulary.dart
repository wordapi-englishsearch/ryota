class Vocabulary {
  final String word;
  final List<String> examples;
  final String definition;

  Vocabulary({
    required this.word,
    required this.examples,
    required this.definition,
  });

factory Vocabulary.fromJson(Map<String, dynamic> json) {
  // `results`がnullでないか確認


  return Vocabulary(
    word: json['word'] ?? '',
    examples: List<String>.from(json['examples'] ?? []),
    definition: json['definition'] ?? '',
  );
  }
}
