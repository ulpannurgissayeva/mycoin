import 'package:flutter/material.dart';
import '../components/side_bar_nav2_model.dart';
import '../components/side_bar_nav3_model.dart';
import '../components/side_bar_nav4_model.dart';
import '../components/side_bar_nav5_model.dart';
import '/components/side_bar_nav6_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'sendbitcoin_widget.dart' show SendbitcoinWidget;

class SendbitcoinModel extends FlutterFlowModel<SendbitcoinWidget> {
  final unfocusNode = FocusNode();
  late SideBarNav6Model sideBarNav6Model;
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  FocusNode? textFieldFocusNode1;
  TextEditingController? textController1;
  String? Function(BuildContext, String?)? textController1Validator;
  FocusNode? textFieldFocusNode2;
  TextEditingController? textController2;
  String? Function(BuildContext, String?)? textController2Validator;
  FocusNode? textFieldFocusNode3;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;

  @override
  void initState(BuildContext context) {
    sideBarNav6Model = createModel(context, () => SideBarNav6Model());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    sideBarNav6Model.dispose();
    textFieldFocusNode1?.dispose();
    textController1?.dispose();
    textFieldFocusNode2?.dispose();
    textController2?.dispose();
    textFieldFocusNode3?.dispose();
    textController3?.dispose();
  }
}

class SendbitcoinWidget extends StatefulWidget {
  @override
  _SendbitcoinWidgetState createState() => _SendbitcoinWidgetState();
}

class _SendbitcoinWidgetState extends State<SendbitcoinWidget> {
  late SendbitcoinModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = SendbitcoinModel();
    _model.initState(context);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_model.unfocusNode.canRequestFocus) {
          FocusScope.of(context).requestFocus(_model.unfocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Transfer Funds'),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              children: [
                // Dropdown, TextFields, and Transfer Button widgets go here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
