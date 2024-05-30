import '/flutter_flow/flutter_flow_util.dart';
import 'seedpage_widget.dart' show SeedpageWidget;
import 'package:flutter/material.dart';

class SeedpageModel extends FlutterFlowModel<SeedpageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
