import '/flutter_flow/flutter_flow_util.dart';
import 'entercode_widget.dart' show EntercodeWidget;
import 'package:flutter/material.dart';

class EntercodeModel extends FlutterFlowModel<EntercodeWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    pinCodeController?.dispose();
  }
}
