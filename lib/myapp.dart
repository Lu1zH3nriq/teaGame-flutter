import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Jogo de Animais',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> animalNames = [
    'C A C H O R R O',
    'G A T O',
    'E L E F A N T E',
    'Z E B R A',
    'P A T O',
    'V A C A',
    'L E Ã O',
    'G I R A F A',
    'T I G R E',
    'C O B R A'
  ];

  List<String> animalImages = [
    'assets/images/dog.png',
    'assets/images/cat.png',
    'assets/images/elephant.png',
    'assets/images/zebra.png',
    'assets/images/duck.png',
    'assets/images/cow.png',
    'assets/images/lion.png',
    'assets/images/giraffe.png',
    'assets/images/tiger.png',
    'assets/images/snake.png'
  ];

  int phaseNumber = 1;
  int score = 0;
  int correctAnswerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(animalNames[phaseNumber - 1]),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(4, (index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (correctAnswerIndex == index) {
                          score++;
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Resposta Correta'),
                                content: Image.asset(
                                  'assets/images/correct.png',
                                  height: 100,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      goToNextPhase();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Resposta Incorreta'),
                                content: Image.asset(
                                  'assets/images/incorrect.png',
                                  height: 100,
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Image.asset(
                          animalImages[index],
                          height: 100,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 16.0),
            Text('Pontuação: $score'),
          ],
        ),
      ),
    );
  }

  void goToNextPhase() {
    setState(() {
      phaseNumber++;
      if (phaseNumber > animalNames.length) {
        phaseNumber = 1;
        score = 0;
      }
      correctAnswerIndex = Random().nextInt(4);
    });
  }
}
