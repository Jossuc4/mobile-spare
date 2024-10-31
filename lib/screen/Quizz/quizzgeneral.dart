import 'package:flutter/material.dart';
import 'package:oscapp/screen/Quizz/question.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Quizzgeneral extends StatefulWidget {
  const Quizzgeneral({super.key});

  @override
  State<Quizzgeneral> createState() => _QuizzgeneralState();
}

class _QuizzgeneralState extends State<Quizzgeneral> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  int _currentLevel = 1;
  int _maxLevel = 3; // Définit le niveau maximum
  List<int> _answers = [];
  List<Map<String, dynamic>> get _questions =>
      questionsByLevel[_currentLevel] ?? [];

  @override
  void initState() {
    super.initState();
    _loadLevel();
  }

  Future<void> _loadLevel() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _currentLevel =
          prefs.getInt('currentLevel') ?? 1; // Charge le niveau actuel
      _currentQuestionIndex = 0; // Réinitialise l'index des questions
      _score = 0; // Réinitialise le score
    });
  }

  Future<void> _saveLevel() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(
        'currentLevel', _currentLevel); // Sauvegarde le niveau actuel
  }

  Future<void> _resetQuiz() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentLevel', 1); // Réinitialise le niveau à 1
    setState(() {
      _currentLevel = 1;
      _currentQuestionIndex = 0;
      _score = 0; // Réinitialise le score
      _answers.clear(); // Réinitialise les réponses
    });
  }

  void _answerQuestion(int selectedOption) {
    setState(() {
      if (selectedOption ==
          _questions[_currentQuestionIndex]['correctAnswer']) {
        _score++;
      }
      _answers.add(selectedOption);
      _currentQuestionIndex++;

      // Vérifie si toutes les questions de ce niveau ont été posées
      if (_currentQuestionIndex >= _questions.length) {
        _showScoreDialog(); // Affiche le dialog avec le score
      }
    });
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Fin du Niveau $_currentLevel'),
          content: Text('Votre score est $_score / ${_questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                if (_currentLevel < _maxLevel) {
                  _currentLevel++;
                  _saveLevel();
                  _currentQuestionIndex = 0;
                  _score = 0;
                }
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
                setState(() {}); // Met à jour l'interface utilisateur
              },
              child: Text('Continuer au Niveau ${_currentLevel + 1}'),
            ),
            TextButton(
              onPressed: () async {
                if (_currentLevel + 1 <= _maxLevel) {
                  _currentLevel += 1;
                } else {
                  // Affiche un message indiquant que le niveau maximum a été atteint
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Niveau Maximum Atteint'),
                        content: Text(
                          "Vous avez atteint le niveau maximum, attendez la nouvelle mise à jour de l'application.",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Ferme le message
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                  return; // Ne continue pas si le niveau maximum a été atteint
                }

                await _saveLevel();
                Navigator.of(context).pop(); // Ferme la boîte de dialogue
                Navigator.pop(context); // Retourne à l'écran précédent
              },
              child: Text('Quitter'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentQuestionIndex + 1) / _questions.length;

    return Scaffold(
      appBar: AppBar(title: Text('Quiz Niveau $_currentLevel')),
      body: _currentQuestionIndex < _questions.length
          ? Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 8.0),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    color: Color(0xFF0BA56A),
                    minHeight: 10,
                  ),
                ),
                SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Question Progress for the Quiz",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        'Question ${_currentQuestionIndex + 1} / ${_questions.length}',
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Question : ",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.white, Colors.white],
                    ),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.white, width: 0.4),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x00000000).withOpacity(0.24),
                        offset: const Offset(2, 4),
                        blurRadius: 6,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Text(
                    _questions[_currentQuestionIndex]['question'],
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Choix : ",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                SizedBox(height: 3),
                ..._questions[_currentQuestionIndex]['options']
                    .map<Widget>((option) {
                  int index = _questions[_currentQuestionIndex]['options']
                      .indexOf(option);
                  return GestureDetector(
                    onTap: () => _answerQuestion(index),
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        padding: const EdgeInsets.all(10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Colors.white, Colors.white],
                          ),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white, width: 1),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x00000000).withOpacity(0.24),
                              offset: const Offset(2, 4),
                              blurRadius: 6,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Text(
                          option,
                          textAlign: TextAlign.center,
                        )),
                  );
                }).toList(),
                SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: _resetQuiz,
                //   child: Text('Réinitialiser le Quiz'),
                // ),
              ],
            )
          : Center(
              child: Text(
                'Votre score est $_score / ${_questions.length}',
                style: TextStyle(fontSize: 24),
              ),
            ),
    );
  }
}
