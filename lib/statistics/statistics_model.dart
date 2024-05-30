import '/components/side_bar_nav3_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'statistics_widget.dart' show StatisticsWidget;
import 'package:flutter/material.dart';

class StatisticsModel extends FlutterFlowModel<StatisticsWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for sideBarNav3 component.
  late SideBarNav3Model sideBarNav3Model;

  @override
  void initState(BuildContext context) {
    sideBarNav3Model = createModel(context, () => SideBarNav3Model());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    sideBarNav3Model.dispose();
  }
}
