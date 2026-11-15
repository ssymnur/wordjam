import 'package:flutter/material.dart';

void main() {
  runApp(const WordJamApp());
}

class WordJamApp extends StatelessWidget {
  const WordJamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WordJam TEST',
      theme: ThemeData(
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFD6E7),
              Color(0xFFE5D5FF),
              Color(0xFFFFE8AE),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // APP TITLE
                const Text(
                  'WordJam',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF7545A5),
                    letterSpacing: 1.5,
                  ),
                ),

                const Text(
                  'Learn a little, grow a lot!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF795D91),
                  ),
                ),

                const SizedBox(height: 35),

                // COLORFUL JAR AREA
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(35),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        '✨ YOUR DAILY WORDS ✨',
                        style: TextStyle(
                          color: Color(0xFF9A62BD),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        '🫙',
                        style: TextStyle(fontSize: 125),
                      ),

                      const SizedBox(height: 10),

                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          wordChip('Dream', Color(0xFFFFA8C5)),
                          wordChip('Smile', Color(0xFFFFD36E)),
                          wordChip('Magic', Color(0xFFBBA0F5)),
                          wordChip('Happy', Color(0xFF8EDBD0)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                const Text(
                  'Ready to discover new words?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF68458C),
                  ),
                ),

                const SizedBox(height: 12),

                const Text(
                  'Open your vocabulary jar and learn\n10 new English words every day!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Color(0xFF806B91),
                  ),
                ),

                const Spacer(),

                // START BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8D8D),
                      foregroundColor: Colors.white,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LevelPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'LET’S START! 🚀',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  'Made with 💜 for word lovers',
                  style: TextStyle(
                    color: Color(0xFF9578A9),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget wordChip(String word, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        word,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Color(0xFF55415F),
        ),
      ),
    );
  }
}

// LEVEL SELECTION PAGE

class LevelPage extends StatelessWidget {
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final levels = [
      {'name': 'A1', 'description': 'Beginner', 'color': Color(0xFFFFA8C5), 'emoji': '🌱'},
      {'name': 'A2', 'description': 'Elementary', 'color': Color(0xFFFFD36E), 'emoji': '🌼'},
      {'name': 'B1', 'description': 'Intermediate', 'color': Color(0xFF9DDBD1), 'emoji': '🌈'},
      {'name': 'B2', 'description': 'Upper Intermediate', 'color': Color(0xFFBBA0F5), 'emoji': '⭐'},
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE5D5FF),
              Color(0xFFFFD6E7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Choose Your Level ✨',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF7545A5),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Which level do you want to start with?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF806B91),
                  ),
                ),

                const SizedBox(height: 30),

                ...levels.map((level) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: level['color'] as Color,
                        foregroundColor: const Color(0xFF55415F),
                        elevation: 3,
                        padding: const EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${level['name']} level selected!',
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            level['emoji'] as String,
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  level['name'] as String,
                                  style: const TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  level['description'] as String,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.arrow_forward_rounded),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
