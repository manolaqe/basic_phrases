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

      if (playerState == PlayerState.completed) {
        setState(() {
          basicPhrases.forEach((element) {
            element.isToggled = false;
          });
        });
      }
    });
  }

  List<PhraseModel> basicPhrases = [
    PhraseModel(
        romanianText: 'salut',
        germanText: 'salut (Germana)',
        isToggled: false,
        romanianAudioPath: "01.mp3",
        germanAudioPath: "02.mp3"),
    PhraseModel(
        romanianText: 'mă numesc',
        germanText: 'mă numesc (Germana)',
        isToggled: false,
        romanianAudioPath: "03.mp3",
        germanAudioPath: "04.mp3"),
    PhraseModel(
        romanianText: 'cum ești',
        germanText: 'cum ești (Germana)',
        isToggled: false,
        romanianAudioPath: "05.mp3",
        germanAudioPath: "06.mp3"),
    PhraseModel(
        romanianText: 'ce faci',
        germanText: 'ce faci (Germana)',
        isToggled: false,
        romanianAudioPath: "07.mp3",
        germanAudioPath: "08.mp3"),
  ];

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
                                    if (playerState != PlayerState.playing) {
                                      setState(() {
                                        basicPhrases[index].isToggled =
                                            !basicPhrases[index].isToggled;
                                      });
                                    }
                                  },
                                  onTapUp: (details) {
                                    if (playerState != PlayerState.playing) {
                                      player.play(AssetSource(
                                          basicPhrases[index]
                                              .romanianAudioPath));
                                    }
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
                                    child: playerState == PlayerState.playing &&
                                            basicPhrases[index].isToggled
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                                color: Colors.green))
                                        : Center(
                                            child: Text(basicPhrases[index]
                                                .romanianText)),
                                  )))),
                      Expanded(
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: GestureDetector(
                                  onTapDown: (details) {
                                    if (playerState != PlayerState.playing) {
                                      setState(() {
                                        basicPhrases[index].isToggled =
                                            !basicPhrases[index].isToggled;
                                      });
                                    }
                                  },
                                  onTapUp: (details) {
                                    if (playerState != PlayerState.playing) {
                                      player.play(AssetSource(
                                          basicPhrases[index].germanAudioPath));
                                    }
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
                                    child: playerState == PlayerState.playing &&
                                            basicPhrases[index].isToggled
                                        ? const Center(
                                            child: CircularProgressIndicator(
                                                color: Colors.green))
                                        : Center(
                                            child: Text(basicPhrases[index]
                                                .germanText)),
                                  )))),
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
  String germanAudioPath;
  String romanianAudioPath;

  PhraseModel(
      {required this.romanianText,
      required this.germanText,
      required this.isToggled,
      required this.romanianAudioPath,
      required this.germanAudioPath});
}
