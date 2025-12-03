import 'package:flutter/material.dart';
import 'package:couldai_user_app/data/mock_course_data.dart';
import 'package:couldai_user_app/models/course_model.dart';
import 'package:couldai_user_app/screens/lesson_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Chapter> _chapters = MockCourseData.getChapters();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.flag, color: Colors.grey), // Language flag placeholder
            Row(
              children: [
                const Icon(Icons.local_fire_department, color: Colors.orange),
                const SizedBox(width: 4),
                Text('0', style: TextStyle(color: Colors.orange[700], fontWeight: FontWeight.bold)),
                const SizedBox(width: 16),
                const Icon(Icons.diamond, color: Colors.blue),
                const SizedBox(width: 4),
                Text('0', style: TextStyle(color: Colors.blue[700], fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 24),
        itemCount: _chapters.length,
        itemBuilder: (context, index) {
          final chapter = _chapters[index];
          return _buildChapterNode(context, chapter, index);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Learn'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Grammar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildChapterNode(BuildContext context, Chapter chapter, int index) {
    // Stagger the nodes slightly left and right to create a path look
    double offset = 0;
    if (index % 2 == 1) offset = 40;
    if (index % 4 == 2) offset = -40; // Simple zig-zag pattern logic

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Transform.translate(
            offset: Offset(offset, 0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    if (!chapter.isLocked) {
                      _showChapterStartDialog(context, chapter);
                    }
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: chapter.isLocked
                          ? Colors.grey[300]
                          : (chapter.isCompleted ? Colors.amber : Theme.of(context).colorScheme.primary),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 0,
                          offset: const Offset(0, 6), // "3D" button effect
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white,
                        width: 4,
                      ),
                    ),
                    child: Icon(
                      chapter.isLocked ? Icons.lock : Icons.star,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  chapter.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showChapterStartDialog(BuildContext context, Chapter chapter) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chapter.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                chapter.description,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                "Grammar Focus:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(chapter.grammarPoint.title),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close sheet
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonScreen(chapter: chapter),
                      ),
                    );
                  },
                  child: const Text("START +10 XP"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
