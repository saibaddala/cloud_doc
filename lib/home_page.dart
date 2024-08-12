import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reptile_run/food_pixel.dart';
import 'package:reptile_run/pixel.dart';
import 'package:reptile_run/snake_pixel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum SnakeDirection { up, down, left, right }

class _HomePageState extends State<HomePage> {
  int rowSize = 10;
  int totalNoOfSquares = 100;

  List<int> snakePos = [0, 1, 2];
  int foodPos = 65;
  int currScore = 0;
  bool hasGameStarted = false;

  var snakeDirection = SnakeDirection.right;

  final _nameController = TextEditingController();

  List<String> highScore_docIds = [];
  late final Future? letsGetDocIds;

  @override
  void initState() {
    letsGetDocIds = getDocs();
    super.initState();
  }

  Future getDocs() async {
    await FirebaseFirestore.instance
        .collection('highscores')
        .orderBy('score', descending: true)
        .limit(5)
        .get()
        .then(
          (value) => value.docs.forEach(
            (element) {
              highScore_docIds.add(element.reference.id);
            },
          ),
        );
  }

  void startGame() {
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {
        changeDirection();

        if (isGameOver()) {
          timer.cancel();
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Game Over"),
                  content: Column(
                    children: [
                      Text(
                        "Your score is $currScore",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      ),
                      TextField(
                        controller: _nameController,
                        decoration:
                            const InputDecoration(hintText: "Enter your name"),
                      ),
                    ],
                  ),
                  actions: [
                    MaterialButton(
                      onPressed: () {
                        submitScore();
                        Navigator.pop(context);
                        newGame();
                      },
                      color: Colors.pink,
                      child: const Text("Submit"),
                    ),
                  ],
                );
              });
        }
      });
    });
  }

  void newGame() {
    setState(() {
      snakePos = [0, 1, 2];
      foodPos = Random().nextInt(totalNoOfSquares);
      hasGameStarted = false;
      currScore = 0;
      snakeDirection = SnakeDirection.right;
    });
  }

  void eatFood() {
    currScore++;
    if (snakePos.contains(foodPos)) {
      foodPos = Random().nextInt(totalNoOfSquares);
    }
  }

  bool isGameOver() {
    List<int> subList = snakePos.sublist(0, snakePos.length - 1);
    if (subList.contains(snakePos.last)) {
      return true;
    }
    return false;
  }

  void changeDirection() {
    switch (snakeDirection) {
      case SnakeDirection.up:
        {
          if (snakePos.last < rowSize) {
            snakePos.add(snakePos.last - rowSize + totalNoOfSquares);
          } else {
            snakePos.add(snakePos.last - rowSize);
          }
          break;
        }

      case SnakeDirection.down:
        {
          if (snakePos.last + rowSize > totalNoOfSquares) {
            snakePos.add(snakePos.last + rowSize - totalNoOfSquares);
          } else {
            snakePos.add(snakePos.last + rowSize);
          }
          break;
        }

      case SnakeDirection.left:
        {
          if (snakePos.last % rowSize == 0) {
            snakePos.add(snakePos.last - 1 + rowSize);
          } else {
            snakePos.add(snakePos.last - 1);
          }
          break;
        }

      case SnakeDirection.right:
        {
          if (snakePos.last % rowSize == 9) {
            snakePos.add(snakePos.last + 1 - rowSize);
          } else {
            snakePos.add(snakePos.last + 1);
          }
          break;
        }
      default:
    }

    if (snakePos.last == foodPos) {
      eatFood();
    } else {
      snakePos.removeAt(0);
    }
  }

  void submitScore() async {
    var db = FirebaseFirestore.instance;
    await db.collection('highscores').add({
      'name': _nameController.text,
      'score': currScore.toInt(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Current Score',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        currScore.toString(),
                        style: const TextStyle(
                          fontSize: 40,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "HighScores",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0 &&
                    snakeDirection != SnakeDirection.up) {
                  snakeDirection = SnakeDirection.down;
                } else if (details.delta.dy < 0 &&
                    snakeDirection != SnakeDirection.down) {
                  snakeDirection = SnakeDirection.up;
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0 &&
                    snakeDirection != SnakeDirection.left) {
                  snakeDirection = SnakeDirection.right;
                } else if (details.delta.dx < 0 &&
                    snakeDirection != SnakeDirection.right) {
                  snakeDirection = SnakeDirection.left;
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                    itemCount: totalNoOfSquares,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowSize,
                    ),
                    itemBuilder: (context, index) {
                      if (snakePos.contains(index)) {
                        return const SnakePixel();
                      } else if (index == foodPos) {
                        return const FoodPixel();
                      } else {
                        return const BlankPixel();
                      }
                    }),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: MaterialButton(
                color: !hasGameStarted ? Colors.pink : Colors.grey,
                onPressed: !hasGameStarted ? startGame : () {},
                child: const Text("PLAY"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
