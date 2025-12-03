import 'package:flutter/material.dart';
import 'package:couldai_user_app/models/course_model.dart';

class LessonScreen extends StatefulWidget {
  final Chapter chapter;

  const LessonScreen({super.key, required this.chapter});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  late Lesson _currentLesson;
  int _currentExerciseIndex = 0;
  double _progressValue = 0.0;
  bool _isAnswerChecked = false;
  bool _isAnswerCorrect = false;
  String? _selectedOption;
  
  // For matching or other complex states, we might need more variables
  
  @override
  void initState() {
    super.initState();
    // For this demo, we just take the first lesson of the chapter
    if (widget.chapter.lessons.isNotEmpty) {
      _currentLesson = widget.chapter.lessons.first;
    } else {
      // Fallback if empty
      _currentLesson = Lesson(id: 'empty', title: 'Empty', exercises: []);
    }
  }

  void _checkAnswer() {
    if (_selectedOption == null && _getCurrentExercise().type != ExerciseType.vocabularyIntro) return;

    final exercise = _getCurrentExercise();
    bool correct = false;

    if (exercise.type == ExerciseType.vocabularyIntro) {
      correct = true; // Always correct for intro cards, just acknowledging
    } else if (exercise.type == ExerciseType.multipleChoice || 
               exercise.type == ExerciseType.translateToEnglish) {
      correct = _selectedOption == exercise.correctAnswer;
    }

    setState(() {
      _isAnswerChecked = true;
      _isAnswerCorrect = correct;
    });
  }

  void _nextExercise() {
    if (_currentExerciseIndex < _currentLesson.exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _progressValue = _currentExerciseIndex / _currentLesson.exercises.length;
        _isAnswerChecked = false;
        _selectedOption = null;
      });
    } else {
      // Lesson Complete
      _showCompletionDialog();
    }
  }

  Exercise _getCurrentExercise() {
    if (_currentLesson.exercises.isEmpty) {
      return Exercise(
        id: 'error', 
        type: ExerciseType.vocabularyIntro, 
        question: 'No exercises found', 
        options: [], 
        correctAnswer: ''
      );
    }
    return _currentLesson.exercises[_currentExerciseIndex];
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Lesson Complete!"),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.emoji_events, size: 64, color: Colors.amber),
            SizedBox(height: 16),
            Text("You've practiced 10 words and learned a new grammar point!"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Go back to home
            },
            child: const Text("CONTINUE"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final exercise = _getCurrentExercise();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: LinearProgressIndicator(
          value: _progressValue + (1 / _currentLesson.exercises.length * (_isAnswerChecked ? 1 : 0)),
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
          minHeight: 12,
          borderRadius: BorderRadius.circular(6),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exercise.type == ExerciseType.vocabularyIntro ? "New Word" : "Select the correct answer",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (exercise.greekText != null)
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.volume_up, color: Colors.blue), // Placeholder for audio
                            const SizedBox(width: 12),
                            Text(
                              exercise.greekText!,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Times New Roman', // Serif looks better for Greek
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  const SizedBox(height: 32),
                  Text(
                    exercise.question,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 24),
                  if (exercise.type == ExerciseType.vocabularyIntro)
                    _buildVocabularyIntro(exercise)
                  else
                    _buildOptions(exercise),
                ],
              ),
            ),
          ),
          _buildBottomBar(exercise),
        ],
      ),
    );
  }

  Widget _buildVocabularyIntro(Exercise exercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Column(
            children: [
              Text(
                exercise.correctAnswer,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 8),
              if (exercise.explanation != null)
                Text(
                  exercise.explanation!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOptions(Exercise exercise) {
    return Column(
      children: exercise.options.map((option) {
        final isSelected = _selectedOption == option;
        final isCorrectAnswer = option == exercise.correctAnswer;
        
        Color borderColor = Colors.grey.shade300;
        Color bgColor = Colors.white;
        
        if (_isAnswerChecked) {
          if (isCorrectAnswer) {
            borderColor = Colors.green;
            bgColor = Colors.green.shade50;
          } else if (isSelected && !isCorrectAnswer) {
            borderColor = Colors.red;
            bgColor = Colors.red.shade50;
          }
        } else if (isSelected) {
          borderColor = Colors.blue;
          bgColor = Colors.blue.shade50;
        }

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: InkWell(
            onTap: _isAnswerChecked ? null : () {
              setState(() {
                _selectedOption = option;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: borderColor, width: 2),
                borderRadius: BorderRadius.circular(16),
                boxShadow: isSelected && !_isAnswerChecked ? [
                  BoxShadow(color: Colors.blue.withOpacity(0.2), blurRadius: 4, offset: const Offset(0, 2))
                ] : [],
              ),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 18,
                  color: _isAnswerChecked && isSelected && !isCorrectAnswer ? Colors.red : Colors.black87,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomBar(Exercise exercise) {
    Color barColor = Colors.white;
    String statusText = "";
    Color statusColor = Colors.transparent;
    IconData? statusIcon;

    if (_isAnswerChecked) {
      if (_isAnswerCorrect) {
        barColor = Colors.green.shade100;
        statusText = "Correct!";
        statusColor = Colors.green.shade800;
        statusIcon = Icons.check_circle;
      } else {
        barColor = Colors.red.shade100;
        statusText = "Correct answer: ${exercise.correctAnswer}";
        statusColor = Colors.red.shade800;
        statusIcon = Icons.cancel;
      }
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: barColor,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_isAnswerChecked) ...[
              Row(
                children: [
                  Icon(statusIcon, color: statusColor, size: 30),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (_selectedOption == null && exercise.type != ExerciseType.vocabularyIntro) 
                    ? null 
                    : (_isAnswerChecked ? _nextExercise : _checkAnswer),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isAnswerChecked 
                      ? (_isAnswerCorrect ? Colors.green : Colors.red) 
                      : Theme.of(context).colorScheme.primary,
                ),
                child: Text(_isAnswerChecked ? "CONTINUE" : "CHECK"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
