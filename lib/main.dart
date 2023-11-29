import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Phrases Audio App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Basic Phrases'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final player = AudioPlayer();
  PlayerState playerState = PlayerState.stopped;

  @override
  void initState() {
    super.initState();
    player.onPlayerStateChanged.listen((PlayerState s) {
      setState(() {
        playerState = s;
      });
    });
  }

  List<PhraseModel> basicPhrases = [
    PhraseModel(
        romanianText: 'salut',
        germanText: 'salut (Germana)',
        isToggled: false,
        audioPath: "01.mp3"),
    PhraseModel(
        romanianText: 'mă numesc',
        germanText: 'mă numesc (Germana)',
        isToggled: false,
        audioPath: "02.mp3"),
    PhraseModel(
        romanianText: 'cum ești',
        germanText: 'cum ești (Germana)',
        isToggled: false,
        audioPath: "03.mp3"),
    PhraseModel(
        romanianText: 'ce faci',
        germanText: 'ce faci (Germana)',
        isToggled: false,
        audioPath: "04.mp3"),
  ];

  void _flipCard(index) {
    setState(() {
      basicPhrases[index].isToggled = !basicPhrases[index].isToggled;
    });
  }

  Widget _buildBack(PhraseModel phrase) {
    return Center(child: CircularProgressIndicator(color: Colors.green));
  }

  Widget _buildFront(PhraseModel phrase) {
    return Center(child: Text(phrase.romanianText));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(widget.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w200, fontSize: 30))),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: basicPhrases.length,
              itemBuilder: (context, index) {
                return Expanded(
                    child: Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: GestureDetector(
                                  onTapDown: (details) {
                                    setState(() {
                                      basicPhrases[index].isToggled =
                                          !basicPhrases[index].isToggled;
                                    });
                                  },
                                  onTapUp: (details) {
                                    player.play(AssetSource(
                                        basicPhrases[index].audioPath));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            colors: [
                                              Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary
                                            ]),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: playerState == PlayerState.playing
                                        ? _buildBack(basicPhrases[index])
                                        : _buildFront(basicPhrases[index]),
                                  )))),
                      Expanded(
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomLeft,
                                        colors: [
                                          Theme.of(context).colorScheme.primary,
                                          Theme.of(context)
                                              .colorScheme
                                              .onPrimary
                                        ]),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                    child: Text(
                                  basicPhrases[index].romanianText,
                                )),
                              ))),
                    ],
                  )
                ]));
              }),
        ));
  }
}

class PhraseModel {
  String romanianText;
  String germanText;
  bool isToggled = false;
  String audioPath;

  PhraseModel(
      {required this.romanianText,
      required this.germanText,
      required this.isToggled,
      required this.audioPath});
}
