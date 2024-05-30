import '/components/side_bar_nav2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for sideBarNav2 component.
  late SideBarNav2Model sideBarNav2Model;

  @override
  void initState(BuildContext context) {
    sideBarNav2Model = createModel(context, () => SideBarNav2Model());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    sideBarNav2Model.dispose();
  }
}
