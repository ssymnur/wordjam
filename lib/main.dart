import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'services/word_service.dart';

void main() {
  runApp(const WordJamApp());
}

const purple = Color(0xFF9568C8);
const pink = Color(0xFFFF91B9);
const lavender = Color(0xFFE9DDFB);
const yellow = Color(0xFFFFE49A);
const mint = Color(0xFFBCE9D9);
const darkPurple = Color(0xFF68458C);

class WordJamApp extends StatelessWidget {
  const WordJamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WordJam',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool _musicEnabled = true;

  @override
  void initState() {
    super.initState();
    _startMusic();
  }

  Future<void> _startMusic() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.setVolume(0.15);
    await _audioPlayer.play(AssetSource('audio/piano.mp3'));
  }

  Future<void> _toggleMusic() async {
    if (_musicEnabled) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }

    setState(() {
      _musicEnabled = !_musicEnabled;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE8D7FF),
              Color(0xFFFFE2F0),
              Color(0xFFFFF1DC),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 18,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 8),

                  // LOGO
                  const Text(
                    'WordJam ✨',
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w900,
                      color: purple,
                      letterSpacing: 1,
                    ),
                  ),

                  const Text(
                    'Learn • Play • Grow',
                    style: TextStyle(
                      fontSize: 16,
                      color: darkPurple,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // MAGICAL JAR

                  const MagicalJar(),

                  const SizedBox(height: 12),

                  // DAILY GOAL
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8EF),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('🎯', style: TextStyle(fontSize: 30)),
                        SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Daily Goal',
                              style: TextStyle(
                                color: purple,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '10 new words',
                              style: TextStyle(
                                color: darkPurple,
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  // START BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LevelPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: pink,
                        foregroundColor: Colors.white,
                        elevation: 5,
                        shadowColor: pink.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                      ),
                      child: const Text(
                        '▶  LET’S START!',
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // BOTTOM DECORATIONS
                     Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BottomItem(
                        emoji: '🏆',
                        label: 'Progress',
                        color: yellow,
                      ),
                      BottomItem(
                        emoji: '💗',
                        label: 'Favorites',
                        color: pink,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: const Color(0xFFFFF8EF),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(28),
                              ),
                            ),
                            builder: (sheetContext) {
                              return StatefulBuilder(
                                builder: (context, setModalState) {
                                  return SafeArea(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            '⚙️ Settings',
                                            style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold,
                                              color: darkPurple,
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          SwitchListTile(
                                            value: _musicEnabled,
                                            onChanged: (value) async {
                                              await _toggleMusic();
                                              setModalState(() {});
                                            },
                                            title: const Text(
                                              'Background Music',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: darkPurple,
                                              ),
                                            ),
                                            subtitle: const Text('Relaxing piano music 🎹'),
                                            secondary: const Icon(
                                              Icons.music_note_rounded,
                                              color: pink,
                                            ),
                                            activeColor: pink,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: const BottomItem(
                          emoji: '⚙️',
                          label: 'Settings',
                          color: lavender,
                        ),
                      ),
                      BottomItem(
                        emoji: '📊',
                        label: 'Stats',
                        color: mint,
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// MAGICAL JAR WIDGET

class MagicalJar extends StatelessWidget {
  const MagicalJar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Positioned(
            top: 25,
            left: 25,
            child: Text('✨', style: TextStyle(fontSize: 32)),
          ),
          const Positioned(
            top: 55,
            right: 30,
            child: Text('⭐', style: TextStyle(fontSize: 27)),
          ),
          const Positioned(
            bottom: 30,
            left: 10,
            child: Text('💫', style: TextStyle(fontSize: 30)),
          ),
          const Positioned(
            bottom: 25,
            right: 10,
            child: Text('✨', style: TextStyle(fontSize: 35)),
          ),

          // GLASS BODY
          Positioned(
            bottom: 10,
            child: Container(
              width: 245,
              height: 205,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFE5C9FF),
                    Color(0xFFFFD7EA),
                    Color(0xFFCFC1FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Colors.white,
                  width: 5,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(65),
                  topRight: Radius.circular(65),
                  bottomLeft: Radius.circular(48),
                  bottomRight: Radius.circular(48),
                ),
                boxShadow: [
                  BoxShadow(
                    color: purple.withOpacity(0.18),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 35,
                    top: 35,
                    child: FloatingLetter(
                      letter: 'A',
                      color: pink,
                      fontSize: 55,
                      duration: 2,
                    ),
                  ),
                  Positioned(
                    right: 30,
                    top: 65,
                    child: FloatingLetter(
                      letter: 'B',
                      color: const Color(0xFFFFC95E),
                      fontSize: 75,
                      duration: 3,
                    ),
                  ),
                  Positioned(
                    left: 85,
                    bottom: 20,
                    child: FloatingLetter(
                      letter: 'C',
                      color: purple,
                      fontSize: 60,
                      duration: 2.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // JAR NECK
          Positioned(
            top: 83,
            child: Container(
              width: 205,
              height: 28,
              decoration: BoxDecoration(
                color: purple,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.white,
                  width: 4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// BOTTOM ITEM

class BottomItem extends StatelessWidget {
  final String emoji;
  final String label;
  final Color color;

  const BottomItem({
    super.key,
    required this.emoji,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 3),
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 25),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(
            color: darkPurple,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

// LEVEL PAGE

class LevelPage extends StatelessWidget {
  const LevelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final levels = [
      ['A1', 'Beginner', '🌱', '0xFFFFD6E7'],
      ['A2', 'Elementary', '🌼', '0xFFFFE7AE'],
      ['B1', 'Intermediate', '🌈', '0xFFBCE9D9'],
      ['B2', 'Upper Intermediate', '⭐', '0xFFE2D3FF'],
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [lavender, Color(0xFFFFE2F0)],
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
                  icon: const Icon(
                    Icons.arrow_back,
                    color: darkPurple,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Choose Your Level ✨',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w900,
                    color: darkPurple,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Where would you like to start?',
                  style: TextStyle(
                    fontSize: 16,
                    color: darkPurple,
                  ),
                ),
                const SizedBox(height: 30),

                ...levels.map((level) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                          int.parse(level[3]),
                        ),
                        foregroundColor: darkPurple,
                        padding: const EdgeInsets.all(20),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      onPressed: () async {
                        try {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${level[0]} words are loading...'),
                            ),
                          );

                          final words = await WordService().fetchWords(level[0]);

                          if (!context.mounted) return;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WordListPage(
                                level: level[0],
                                words: words,
                              ),
                            ),
                          );
                        } catch (e) {
                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Words could not be loaded: $e'),
                            ),
                          );
                        }
                      },
                      child: Row(
                        children: [
                          Text(
                            level[2],
                            style: const TextStyle(fontSize: 32),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  level[0],
                                  style: const TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(level[1]),
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

class WordListPage extends StatelessWidget {
  final String level;
  final List<Map<String, dynamic>> words;

  const WordListPage({
    super.key,
    required this.level,
    required this.words,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$level Vocabulary ✨'),
        backgroundColor: lavender,
        foregroundColor: darkPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              lavender,
              Color(0xFFFFE2F0),
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: words.length,
          itemBuilder: (context, index) {
            final word = words[index];

            return Card(
              margin: const EdgeInsets.only(bottom: 14),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      word['word'],
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: darkPurple,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      word['meaning'],
                      style: const TextStyle(
                        fontSize: 17,
                        color: pink,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(word['example']),
                    const SizedBox(height: 4),
                    Text(
                      word['exampleMeaning'],
                      style: const TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class FloatingLetter extends StatefulWidget {
  final String letter;
  final Color color;
  final double fontSize;
  final double duration;

  const FloatingLetter({
    super.key,
    required this.letter,
    required this.color,
    required this.fontSize,
    this.duration = 2,
  });

  @override
  State<FloatingLetter> createState() => _FloatingLetterState();
}

class _FloatingLetterState extends State<FloatingLetter>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: (widget.duration * 1000).round(),
      ),
    );

    animation = Tween<double>(
      begin: -10,
      end: 10,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );

    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, animation.value),
          child: child,
        );
      },
      child: Text(
        widget.letter,
        style: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: FontWeight.w900,
          color: widget.color,
        ),
      ),
    );
  }
}
