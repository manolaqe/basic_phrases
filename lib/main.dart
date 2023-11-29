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
  final AudioPlayer player = AudioPlayer();
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
          for (int i = 0; i < basicPhrases.length; i++) {
            basicPhrases[i].romanianIsToggled = false;
            basicPhrases[i].germanIsToggled = false;
          }
        });
      }
    });
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  List<PhraseModel> basicPhrases = <PhraseModel>[
    PhraseModel(
      romanianText: 'salut',
      germanText: 'salut (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '01.mp3',
      germanAudioPath: '02.mp3',
    ),
    PhraseModel(
      romanianText: 'mă numesc',
      germanText: 'mă numesc (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '03.mp3',
      germanAudioPath: '04.mp3',
    ),
    PhraseModel(
      romanianText: 'cum ești',
      germanText: 'cum ești (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '05.mp3',
      germanAudioPath: '06.mp3',
    ),
    PhraseModel(
      romanianText: 'ce faci',
      germanText: 'ce faci (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '07.mp3',
      germanAudioPath: '08.mp3',
    ),
    PhraseModel(
      romanianText: 'bună ziua',
      germanText: 'bună ziua (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '01.mp3',
      germanAudioPath: '02.mp3',
    ),
    PhraseModel(
      romanianText: 'mulțumesc',
      germanText: 'mulțumesc (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '03.mp3',
      germanAudioPath: '04.mp3',
    ),
    PhraseModel(
      romanianText: 'la revedere',
      germanText: 'la revedere (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '05.mp3',
      germanAudioPath: '06.mp3',
    ),
    PhraseModel(
      romanianText: 'scuze',
      germanText: 'scuze (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '07.mp3',
      germanAudioPath: '08.mp3',
    ),
    PhraseModel(
      romanianText: 'unde este',
      germanText: 'unde este (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '01.mp3',
      germanAudioPath: '02.mp3',
    ),
    PhraseModel(
      romanianText: 'ceasul',
      germanText: 'ceasul (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '03.mp3',
      germanAudioPath: '04.mp3',
    ),
    PhraseModel(
      romanianText: 'îmi place',
      germanText: 'îmi place (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '05.mp3',
      germanAudioPath: '06.mp3',
    ),
    PhraseModel(
      romanianText: 'nu înțeleg',
      germanText: 'nu înțeleg (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '07.mp3',
      germanAudioPath: '08.mp3',
    ),
    PhraseModel(
      romanianText: 'vă rog',
      germanText: 'vă rog (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '01.mp3',
      germanAudioPath: '02.mp3',
    ),
    PhraseModel(
      romanianText: 'îmi pare rău',
      germanText: 'îmi pare rău (Germana)',
      romanianIsToggled: false,
      germanIsToggled: false,
      romanianAudioPath: '03.mp3',
      germanAudioPath: '04.mp3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 30))),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: basicPhrases.length,
              itemBuilder: (BuildContext context, int index) {
                return Expanded(
                    child: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: GestureDetector(
                                  onTapDown: (TapDownDetails details) {
                                    if (playerState != PlayerState.playing) {
                                      setState(() {
                                        basicPhrases[index].romanianIsToggled = !basicPhrases[index].romanianIsToggled;
                                      });
                                    }
                                  },
                                  onTapUp: (TapUpDetails details) {
                                    if (playerState != PlayerState.playing) {
                                      player.play(AssetSource(basicPhrases[index].romanianAudioPath));
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(begin: Alignment.bottomLeft, colors: <Color>[
                                          Theme.of(context).colorScheme.onPrimary,
                                          Theme.of(context).colorScheme.primary
                                        ]),
                                        borderRadius: BorderRadius.circular(30)),
                                    child: playerState == PlayerState.playing && basicPhrases[index].romanianIsToggled
                                        ? const Center(child: CircularProgressIndicator(color: Colors.green))
                                        : Center(
                                            child: Text(
                                            basicPhrases[index].romanianText,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                                          )),
                                  )))),
                      Expanded(
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: GestureDetector(
                                  onTapDown: (TapDownDetails details) {
                                    if (playerState != PlayerState.playing) {
                                      setState(() {
                                        basicPhrases[index].germanIsToggled = !basicPhrases[index].germanIsToggled;
                                      });
                                    }
                                  },
                                  onTapUp: (TapUpDetails details) {
                                    if (playerState != PlayerState.playing) {
                                      player.play(AssetSource(basicPhrases[index].germanAudioPath));
                                    }
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(begin: Alignment.bottomLeft, colors: <Color>[
                                          Theme.of(context).colorScheme.primary,
                                          Theme.of(context).colorScheme.onPrimary
                                        ]),
                                        borderRadius: BorderRadius.circular(30)),
                                    child: playerState == PlayerState.playing && basicPhrases[index].germanIsToggled
                                        ? const Center(child: CircularProgressIndicator(color: Colors.green))
                                        : Center(
                                            child: Text(
                                            textAlign: TextAlign.center,
                                            basicPhrases[index].germanText,
                                            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                                          )),
                                  )))),
                    ],
                  )
                ]));
              }),
        ));
  }
}

class PhraseModel {
  PhraseModel(
      {required this.romanianText,
      required this.germanText,
      required this.romanianIsToggled,
      required this.germanIsToggled,
      required this.romanianAudioPath,
      required this.germanAudioPath});

  String romanianText;
  String germanText;
  bool romanianIsToggled = false;
  bool germanIsToggled = false;
  String germanAudioPath;
  String romanianAudioPath;
}
