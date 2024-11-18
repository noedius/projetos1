import 'package:flutter/material.dart';

void main() {
  runApp(ImscaredQuizApp());
}

/// Widget principal do aplicativo
/// Configura o tema e define a tela inicial
class ImscaredQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove a faixa de debug
      title: 'Imscared Quiz',
      theme: ThemeData(
        primarySwatch: Colors.red, // Define a cor primária do tema
      ),
      home: StartScreen(), // Tela inicial do aplicativo
    );
  }
}

/// Tela inicial do aplicativo
/// Mostra o título, logotipo e o botão para iniciar o quiz
class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fundo preto para atmosfera do jogo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', height: 150), // Logotipo do quiz
            const SizedBox(height: 20), // Espaçamento entre elementos
            Text(
              'Imscared Quiz', // Nome do aplicativo
              style: TextStyle(
                color: Colors.white, // Texto branco
                fontSize: 28, // Tamanho do texto
                fontWeight: FontWeight.bold, // Texto em negrito
              ),
            ),
            const SizedBox(height: 40), // Espaçamento extra
            ElevatedButton(
              onPressed: () {
                // Navega para a tela do quiz
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
              child: const Text('Iniciar Quiz'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tela do quiz
/// Exibe a pergunta atual, imagem e opções de múltipla escolha
class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // Lista de perguntas com imagem, opções e resposta correta
  final List<Map<String, Object>> _questions = [
    {
      'question': 'Quem é o personagem principal de Imscared?',
      'image': 'assets/question1.png',
      'options': ['Você mesmo', 'Um espírito', 'Um soldado', 'Uma entidade'],
      'answer': 'Você mesmo', // Resposta correta
    },
    {
      'question': 'O que Imscared é conhecido por fazer com o jogo?',
      'image': 'assets/question2.png',
      'options': ['Criar arquivos falsos', 'Apagar dados do jogador', 'Fechar sozinho', 'Hackear o sistema'],
      'answer': 'Criar arquivos falsos', // Resposta correta
    },
    {
      'question': 'Qual o nome do antagonista do jogo?',
      'image': 'assets/question3.png',
      'options': ['You', 'Ivan Zanotti', 'White Face', 'HER'],
      'answer': 'White Face', // Resposta correta
    },
    {
      'question': 'Em que ano o jogo completo foi lançado?',
      'image': 'assets/question4.png',
      'options': ['2012', '2022', '2016', '2009'],
      'answer': '2016', // Resposta correta
    },
    {
      'question': 'O que deve ser feito para terminar o jogo?',
      'image': 'assets/question5.png',
      'options': ['Apagar o White Face', 'Apagar os dados do jogador', 'Apagar o jogo', 'Apagar o coração'],
      'answer': 'Apagar o coração', // Resposta correta
    },
  ];

  int _currentQuestionIndex = 0; // Índice da pergunta atual
  int _score = 0; // Pontuação do jogador

  /// Função para tratar a resposta do usuário
  void _answerQuestion(String selectedOption) {
    // Verifica se a resposta está correta e atualiza a pontuação
    if (selectedOption == _questions[_currentQuestionIndex]['answer']) {
      _score++;
    }

    setState(() {
      // Avança para a próxima pergunta ou exibe os resultados
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        // Navega para a tela de resultados
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(score: _score, total: _questions.length)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_currentQuestionIndex]; // Pergunta atual
    return Scaffold(
      backgroundColor: Colors.black, // Fundo preto
      appBar: AppBar(
        title: Text('Pergunta ${_currentQuestionIndex + 1} de ${_questions.length}'),
        centerTitle: true, // Centraliza o título no AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(55.0), // Espaçamento geral
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              question['image'] as String, // Imagem da pergunta
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              question['question'] as String, // Texto da pergunta
              style: TextStyle(color: Colors.white, fontSize: 20), // Estilo do texto
              textAlign: TextAlign.center, // Centraliza o texto da pergunta
            ),
            const SizedBox(height: 30),
            // Lista de opções como botões
            ...((question['options'] as List<String>).map((option) {
              return ElevatedButton(
                onPressed: () => _answerQuestion(option), // Chama a função de resposta
                child: Text(option),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  backgroundColor: Colors.black, // Cor dos botões
                ),
              );
            }).toList()),
          ],
        ),
      ),
    );
  }
}

/// Tela de resultados
/// Exibe a pontuação final e oferece a opção de reiniciar o quiz
class ResultScreen extends StatelessWidget {
  final int score; // Pontuação final
  final int total; // Total de perguntas

  ResultScreen({required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Fundo preto
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pontuação Final', // Título
              style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              '$score / $total', // Exibe a pontuação final
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                // Reinicia o quiz, voltando à tela inicial
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StartScreen()),
                );
              },
              child: const Text('Reiniciar Quiz'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
