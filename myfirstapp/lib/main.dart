import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mobile App Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// First Screen - StatelessWidget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile App Lab'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.flutter_dash,
                size: 90,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20),

              const Text(
                'Interactive Flutter App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'This screen is created using a StatelessWidget.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const InteractiveScreen(),
                    ),
                  );
                },
                child: const Text('Go to Interactive Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Second Screen - StatefulWidget
class InteractiveScreen extends StatefulWidget {
  const InteractiveScreen({super.key});

  @override
  State<InteractiveScreen> createState() => _InteractiveScreenState();
}

class _InteractiveScreenState extends State<InteractiveScreen>
    with SingleTickerProviderStateMixin {
  String message = 'Press the button below';
  late final AnimationController _confettiController;
  bool hasChangedText = false;

  @override
  void initState() {
    super.initState();
    _confettiController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..forward();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void changeMessage() {
    setState(() {
      message = 'Hello! The text has changed.';
      hasChangedText = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nice! You unlocked a new message.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive Screen'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.touch_app,
                    size: 80,
                    color: Colors.deepPurple,
                  ),

                  const SizedBox(height: 20),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: Text(
                      message,
                      key: ValueKey(message),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: hasChangedText ? null : changeMessage,
                    child: Text(
                      hasChangedText ? 'Text Changed' : 'Change Text',
                    ),
                  ),

                  const SizedBox(height: 15),

                  OutlinedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Go Back'),
                  ),
                ],
              ),
            ),
          ),
          IgnorePointer(
            child: AnimatedBuilder(
              animation: _confettiController,
              builder: (context, child) {
                return CustomPaint(
                  painter: _ConfettiPainter(_confettiController.value),
                  size: Size.infinite,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  _ConfettiPainter(this.progress);

  final double progress;
  static const colors = [
    Colors.deepPurple,
    Colors.amber,
    Colors.teal,
    Colors.pink,
    Colors.blue,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (var index = 0; index < 36; index++) {
      final startX = (index * 47.0) % size.width;
      final drift = (index.isEven ? 1 : -1) * 26 * progress;
      final x = startX + drift;
      final y = -20 + (index % 9) * 12 + progress * (size.height * .72);
      paint.color = colors[index % colors.length].withValues(
        alpha: (1 - progress).clamp(.0, 1.0),
      );
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(x, y),
          width: 8,
          height: 12,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}