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


class WordListPage extends StatefulWidget {
  final String level;
  final List<Map<String, dynamic>> words;

  const WordListPage({
    super.key,
    required this.level,
    required this.words,
  });

  @override
  State<WordListPage> createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  int currentIndex = 0;
  int xp = 0;
  final Set<int> learnedWords = {};

  void nextWord() {
    if (currentIndex < widget.words.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Tebrikler! Bu seviyedeki tüm kelimeleri gördün ✨'),
        ),
      );
    }
  }

  void markAsLearned() {
    if (learnedWords.contains(currentIndex)) return;

    setState(() {
      learnedWords.add(currentIndex);
      xp += 10;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('+10 XP kazandın! Harika gidiyorsun 💗'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.words.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('Bu seviyede henüz kelime bulunmuyor.'),
        ),
      );
    }

    final word = widget.words[currentIndex];

    final String wordText = word['word']?.toString() ?? '';
    final String meaning = word['meaning']?.toString() ?? '';
    final String example = word['example']?.toString() ?? '';
    final String exampleMeaning =
        word['exampleMeaning']?.toString() ?? '';

    final String wordType =
        word['type']?.toString() ?? 'KELİME';

    final String pronunciation =
        word['pronunciation']?.toString() ?? '';

    final bool isLearned = learnedWords.contains(currentIndex);

    return Scaffold(
      backgroundColor: const Color(0xFFFFFCF7),

      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 17),
                    label: const Text('Kavanoz'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF45546D),
                      side: const BorderSide(
                        color: Color(0xFFDDE5F1),
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0FF),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      '${widget.level} • #${currentIndex + 1}/${widget.words.length}',
                      style: const TextStyle(
                        color: Color(0xFF6252F5),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // WORD CARD
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFFFFF3FA),
                        Color(0xFFFFE3EA),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(38),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.pink.withOpacity(0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Column(
                    children: [
                      // WORD TYPE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 17,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.85),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text(
                              wordType.toUpperCase(),
                              style: const TextStyle(
                                color: Color(0xFFE92D80),
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),

                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Kelime seslendirmesini bir sonraki adımda ekleyeceğiz 🔊',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.volume_up_rounded,
                              size: 30,
                              color: Color(0xFF39465D),
                            ),
                            style: IconButton.styleFrom(
                              backgroundColor: Colors.white,
                              fixedSize: const Size(55, 55),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 35),

                      // DECORATIVE ICON
                      Container(
                        width: 125,
                        height: 125,
                        decoration: const BoxDecoration(
                          color: Color(0xFFFBE5F2),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            '☺',
                            style: TextStyle(
                              fontSize: 85,
                              color: Color(0xFFE83E91),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ENGLISH WORD
                      Text(
                        wordText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          color: Color(0xFF17172E),
                        ),
                      ),

                      if (pronunciation.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text(
                          pronunciation,
                          style: const TextStyle(
                            fontSize: 19,
                            color: Color(0xFF71809A),
                          ),
                        ),
                      ],

                      const SizedBox(height: 25),

                      // TURKISH MEANING
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 22,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'TÜRKÇE ANLAMI',
                              style: TextStyle(
                                color: Color(0xFF9AA9C0),
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              meaning,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFF202B40),
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // EXAMPLE SENTENCE
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(28),
                          border: Border.all(
                            color: Colors.white,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ÖRNEK CÜMLE',
                              style: TextStyle(
                                color: Color(0xFF687991),
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),
                            ),

                            const SizedBox(height: 12),

                            Text(
                              '"$example"',
                              style: const TextStyle(
                                color: Color(0xFF202B40),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              exampleMeaning,
                              style: const TextStyle(
                                color: Color(0xFF71809A),
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ACTION BUTTONS
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 12,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: nextWord,
                      icon: const Icon(Icons.arrow_forward_ios),
                      label: const Text('Sonraki Kağıt'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF39465D),
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: Color(0xFFDDE5F1),
                          width: 1.5,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 22,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: isLearned ? null : markAsLearned,
                      icon: const Icon(Icons.check_circle_outline),
                      label: Text(
                        isLearned ? 'Öğrenildi!' : 'Öğrendim! (+10 XP)',
                        textAlign: TextAlign.center,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF079B70),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFF079B70),
                        disabledForegroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 22,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // BOTTOM NAVIGATION
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 8,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Color(0xFFE9EDF4),
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _BottomItem(
                    icon: Icons.auto_awesome,
                    label: 'Kavanoz',
                    selected: true,
                  ),
                  _BottomItem(
                    icon: Icons.layers_outlined,
                    label: 'Kelimeler',
                  ),
                  _BottomItem(
                    icon: Icons.menu_book_rounded,
                    label: 'Hikâye',
                  ),
                  _BottomItem(
                    icon: Icons.help_outline_rounded,
                    label: 'Quiz',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;

  const _BottomItem({
    required this.icon,
    required this.label,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 25,
          color: selected
              ? const Color(0xFF6252F5)
              : const Color(0xFF96A6BD),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: selected
                ? const Color(0xFF6252F5)
                : const Color(0xFF96A6BD),
          ),
        ),
      ],
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
