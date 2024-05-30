import '/components/side_bar_nav5_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'profile_page_widget.dart' show ProfilePageWidget;
import 'package:flutter/material.dart';

class ProfilePageModel extends FlutterFlowModel<ProfilePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for sideBarNav5 component.
  late SideBarNav5Model sideBarNav5Model;

  @override
  void initState(BuildContext context) {
    sideBarNav5Model = createModel(context, () => SideBarNav5Model());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    sideBarNav5Model.dispose();
  }
}
