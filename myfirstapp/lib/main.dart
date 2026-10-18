import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gesture Lab',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
      ),
      home: const GestureScreen(),
    );
  }
}

class GestureScreen extends StatefulWidget {
  const GestureScreen({super.key});

  @override
  State<GestureScreen> createState() => _GestureScreenState();
}

class _GestureScreenState extends State<GestureScreen> {
  String message = 'Try a gesture below';
  Color boxColor = Colors.deepPurple;

  void handleTap() {
    setState(() {
      message = 'You tapped the box!';
      boxColor = Colors.blue;
    });
  }

  void handleLongPress() {
    setState(() {
      message = 'Long press detected!';
      boxColor = Colors.orange;
    });
  }

  void handleSwipe() {
    setState(() {
      message = 'You swiped the box!';
      boxColor = Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gesture-Controlled Interface'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              GestureDetector(
                onTap: handleTap,
                onLongPress: handleLongPress,
                onHorizontalDragEnd: (details) {
                  handleSwipe();
                },
                child: Container(
                  width: 250,
                  height: 180,
                  decoration: BoxDecoration(
                    color: boxColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      'Tap, Long Press,\nor Swipe Me',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    message = 'Try a gesture below';
                    boxColor = Colors.deepPurple;
                  });
                },
                child: const Text('Reset'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}