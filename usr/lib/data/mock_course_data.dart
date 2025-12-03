import 'package:couldai_user_app/models/course_model.dart';

class MockCourseData {
  static List<Chapter> getChapters() {
    return [
      Chapter(
        id: 'c1',
        title: 'Intro & The Alphabet',
        description: 'Learn the basics of reading and simple nouns.',
        isLocked: false,
        isCompleted: false,
        grammarPoint: GrammarPoint(
          title: 'The Greek Alphabet & Noun Gender',
          explanation: 'Ancient Greek has a different alphabet. Nouns have genders: Masculine, Feminine, and Neuter.',
          markdownContent: """
# The Alphabet
Ancient Greek uses a unique alphabet. Here are some basics:
- **Α α** (Alpha) - like 'a' in father
- **Β β** (Beta) - like 'b' in bat
- **Γ γ** (Gamma) - like 'g' in go
- **Ο ο** (Omicron) - short 'o' like in pot
- **Ω ω** (Omega) - long 'o' like in raw

# Genders
Every noun in Greek has a gender:
1. **Masculine** (often ends in -os)
2. **Feminine** (often ends in -a or -e)
3. **Neuter** (often ends in -on)
""",
        ),
        vocabularyList: [
          Vocabulary(greekWord: 'ἄνθρωπος', transliteration: 'anthrōpos', englishDefinition: 'human/man', partOfSpeech: 'noun', gender: 'm'),
          Vocabulary(greekWord: 'λόγος', transliteration: 'logos', englishDefinition: 'word/reason', partOfSpeech: 'noun', gender: 'm'),
          Vocabulary(greekWord: 'δώρον', transliteration: 'dōron', englishDefinition: 'gift', partOfSpeech: 'noun', gender: 'n'),
          Vocabulary(greekWord: 'τέχνη', transliteration: 'technē', englishDefinition: 'art/skill', partOfSpeech: 'noun', gender: 'f'),
          Vocabulary(greekWord: 'καί', transliteration: 'kai', englishDefinition: 'and', partOfSpeech: 'conjunction'),
        ],
        lessons: [
          Lesson(
            id: 'l1',
            title: 'Lesson 1: First Words',
            exercises: [
              Exercise(
                id: 'e1',
                type: ExerciseType.vocabularyIntro,
                question: 'New Word: ἄνθρωπος',
                greekText: 'ἄνθρωπος',
                options: [],
                correctAnswer: 'human/man',
                explanation: 'ἄνθρωπος (anthrōpos) means human being or man.',
              ),
              Exercise(
                id: 'e2',
                type: ExerciseType.multipleChoice,
                question: 'Select the correct meaning for: ἄνθρωπος',
                greekText: 'ἄνθρωπος',
                options: ['human', 'gift', 'art'],
                correctAnswer: 'human',
              ),
              Exercise(
                id: 'e3',
                type: ExerciseType.vocabularyIntro,
                question: 'New Word: δώρον',
                greekText: 'δώρον',
                options: [],
                correctAnswer: 'gift',
                explanation: 'δώρον (dōron) is a neuter noun meaning gift.',
              ),
              Exercise(
                id: 'e4',
                type: ExerciseType.multipleChoice,
                question: 'Which word means "gift"?',
                greekText: null,
                options: ['δώρον', 'λόγος', 'τέχνη'],
                correctAnswer: 'δώρον',
              ),
            ],
          ),
          Lesson(
            id: 'l2',
            title: 'Lesson 2: Simple Sentences',
            exercises: [
              Exercise(
                id: 'e5',
                type: ExerciseType.translateToEnglish,
                question: 'Translate this phrase:',
                greekText: 'λόγος καὶ τέχνη',
                options: ['word and art', 'art and word', 'gift and man'],
                correctAnswer: 'word and art',
              ),
            ],
          ),
        ],
      ),
      Chapter(
        id: 'c2',
        title: 'Nominative Case',
        description: 'Subjects of the sentence.',
        isLocked: true,
        isCompleted: false,
        grammarPoint: GrammarPoint(
          title: 'The Nominative Case',
          explanation: 'The subject of a verb is in the nominative case.',
          markdownContent: '...',
        ),
        vocabularyList: [],
        lessons: [],
      ),
      Chapter(
        id: 'c3',
        title: 'Present Verbs',
        description: 'Basic actions in the present tense.',
        isLocked: true,
        isCompleted: false,
        grammarPoint: GrammarPoint(
          title: 'Present Active Indicative',
          explanation: '-ω verbs.',
          markdownContent: '...',
        ),
        vocabularyList: [],
        lessons: [],
      ),
    ];
  }
}
