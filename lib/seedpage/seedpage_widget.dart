import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'seedpage_model.dart';
export 'seedpage_model.dart';
import 'dart:math';

class SeedpageWidget extends StatefulWidget {
  const SeedpageWidget({super.key});

  @override
  State<SeedpageWidget> createState() => _SeedpageWidgetState();
}

class _SeedpageWidgetState extends State<SeedpageWidget> {
  late SeedpageModel _model;
  List<String> randomWords = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SeedpageModel());
    generateRandomWords();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void generateRandomWords() {
    List<String> words = [
      'apple', 'banana', 'cat', 'dog', 'elephant', 'fish', 'grape', 'hat', 'ice', 'juice',
      'kite', 'lemon', 'mouse', 'nest', 'orange', 'pencil', 'queen', 'rabbit', 'sun', 'table',
      'umbrella', 'vase', 'water', 'xylophone', 'yogurt', 'zebra', 'ant', 'bear', 'cloud',
      'duck', 'egg', 'frog', 'goat', 'horse', 'ink', 'jelly', 'kite', 'lion', 'monkey',
      'nut', 'owl', 'pear', 'quack', 'rabbit', 'snake', 'tiger', 'umbrella', 'violin', 'wolf',
      'xylophone', 'yak', 'zebra', 'anchor', 'ball', 'cake', 'duck', 'eggplant', 'flower',
      'goat', 'house', 'cream', 'jacket', 'kiwi', 'lamp', 'mouse', 'nail', 'orange', 'pizza',
      'quill', 'rainbow', 'sun', 'tree', 'unicorn', 'van', 'watermelon', 'xylophone', 'yawn',
      'zebra', 'antelope', 'butterfly', 'carrot', 'daisy', 'eagle', 'frog', 'guitar', 'hammer',
      'igloo', 'jellyfish', 'koala', 'ladder', 'moon', 'nut', 'octopus', 'panda', 'quilt', 'robot',
      'star', 'turtle', 'umbrella', 'vase'
    ];

    final random = Random();
    Set<String> uniqueWords = {};
    while (uniqueWords.length < 10) {
      uniqueWords.add(words[random.nextInt(words.length)]);
    }
    randomWords = uniqueWords.toList();
    saveWordsToFirestore(randomWords);
  }

  Future<void> saveWordsToFirestore(List<String> words) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final userDoc = FirebaseFirestore.instance.collection('user_words').doc(user.uid);
      final userDocSnapshot = await userDoc.get();

      if (!userDocSnapshot.exists) {
        await userDoc.set({
          'user_id': user.uid,
          'words': words,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _model.unfocusNode.canRequestFocus
        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
        : FocusScope.of(context).unfocus(),
    child: Scaffold(
    key: scaffoldKey,
    backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
    body: SafeArea(
    top: true,
    child: SingleChildScrollView(
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    SizedBox(height: 100),
    Text(
    FFLocalizations.of(context).getText(
    '429xejhk' /* Seed фразаларды өзіңізге жазып... */,
    ),
    style: FlutterFlowTheme.of(context)
        .bodyMedium
        .override(
    fontFamily: FlutterFlowTheme.of(context)
        .bodyMediumFamily,
    fontSize: 40.0,
    letterSpacing: 0.0,
    useGoogleFonts: GoogleFonts.asMap()
        .containsKey(
    FlutterFlowTheme.of(context)
        .bodyMediumFamily),
    ),
    ),
    SizedBox(height: 40),
    Text(
    FFLocalizations.of(context).getText(
    'ako0hkvy' /* Төмендегі рандомды сөздер сізд... */,
    ),
    textAlign: TextAlign.center,
    style: FlutterFlowTheme.of(context)
        .bodyMedium
        .override(
    fontFamily: FlutterFlowTheme.of(context)
        .bodyMediumFamily,
    fontSize: 20.0,
    letterSpacing: 0.0,
    useGoogleFonts: GoogleFonts.asMap()
        .containsKey(
    FlutterFlowTheme.of(context)
        .bodyMediumFamily),
    ),
    ),
    SizedBox(height: 50),
    SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(
    5,
    (index) => Padding(
    padding: const EdgeInsetsDirectional
        .fromSTEB(
    0.0, 0.0, 0.0, 30.0),
    child: Container(
    width: 279.0,
    height: 55.0,
    decoration: BoxDecoration(
    color: const Color(0x30616161),
    borderRadius:
    BorderRadius.circular(12.0),
    border: Border.all(
    color: const Color(0x61FFBB0D)),
    ),
    alignment: const AlignmentDirectional(
    0.0, 0.0),
    child: Text(
    randomWords[index],
    style: TextStyle(fontSize: 20.0),
    ),
    ),
    )),
    ),
    Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(
    5,
    (index) => Padding(
    padding: const EdgeInsetsDirectional
        .fromSTEB(
    0.0, 0.0, 0.0, 30.0),
    child: Container(
    width: 279.0,
    height: 55.0,
      decoration: BoxDecoration(
        color: const Color(0x30616161),
        borderRadius:
        BorderRadius.circular(12.0),
        border: Border.all(
            color: const Color(0x61FFBB0D)),
      ),
      alignment: const AlignmentDirectional(
          0.0, 0.0),
      child: Text(
        randomWords[index + 5],
        style: TextStyle(fontSize: 20.0),
      ),
    ),
    )),
    ),
    ],
    ),
    ),
      SizedBox(height: 40),
      FFButtonWidget(
        onPressed: () async {
          context.pushNamed('homePage');
        },
        text: FFLocalizations.of(context).getText(
          '1biz1wkh' /* Келесі */,
        ),
        options: FFButtonOptions(
          width: 339.0,
          height: 40.0,
          padding: const EdgeInsetsDirectional.fromSTEB(
              24.0, 0.0, 24.0, 0.0),
          iconPadding:
          const EdgeInsetsDirectional.fromSTEB(
              0.0, 0.0, 0.0, 0.0),
          color:
          FlutterFlowTheme.of(context).primary,
          textStyle: FlutterFlowTheme.of(context)
              .titleSmall
              .override(
            fontFamily: FlutterFlowTheme.of(
                context)
                .titleSmallFamily,
            color: Colors.white,
            letterSpacing: 0.0,
            useGoogleFonts: GoogleFonts.asMap()
                .containsKey(
                FlutterFlowTheme.of(context)
                    .titleSmallFamily),
          ),
          elevation: 3.0,
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      SizedBox(height: 40),
    ],
    ),
    ),
    ),
    ),
    );
  }
}

