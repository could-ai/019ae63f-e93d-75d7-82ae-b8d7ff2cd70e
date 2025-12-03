class Chapter {
  final String id;
  final String title;
  final String description;
  final GrammarPoint grammarPoint;
  final List<Vocabulary> vocabularyList;
  final List<Lesson> lessons;
  final bool isLocked;
  final bool isCompleted;

  Chapter({
    required this.id,
    required this.title,
    required this.description,
    required this.grammarPoint,
    required this.vocabularyList,
    required this.lessons,
    this.isLocked = false,
    this.isCompleted = false,
  });
}

class GrammarPoint {
  final String title;
  final String explanation;
  final String markdownContent; // For rich text explanation

  GrammarPoint({
    required this.title,
    required this.explanation,
    required this.markdownContent,
  });
}

class Vocabulary {
  final String greekWord;
  final String transliteration;
  final String englishDefinition;
  final String partOfSpeech;
  final String? gender; // m, f, n for nouns

  Vocabulary({
    required this.greekWord,
    required this.transliteration,
    required this.englishDefinition,
    required this.partOfSpeech,
    this.gender,
  });
}

class Lesson {
  final String id;
  final String title;
  final List<Exercise> exercises;

  Lesson({
    required this.id,
    required this.title,
    required this.exercises,
  });
}

enum ExerciseType {
  vocabularyIntro,
  multipleChoice,
  translateToEnglish,
  translateToGreek,
  matching,
}

class Exercise {
  final String id;
  final ExerciseType type;
  final String question;
  final String? greekText;
  final List<String> options;
  final String correctAnswer;
  final String? explanation;

  Exercise({
    required this.id,
    required this.type,
    required this.question,
    this.greekText,
    required this.options,
    required this.correctAnswer,
    this.explanation,
  });
}
