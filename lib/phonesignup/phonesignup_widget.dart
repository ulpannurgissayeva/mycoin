import 'package:firebase_auth/firebase_auth.dart';

import '../entercode/entercode_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'phonesignup_model.dart';
export 'phonesignup_model.dart';

class PhonesignupWidget extends StatefulWidget {
  const PhonesignupWidget({super.key});

  @override
  State<PhonesignupWidget> createState() => _PhonesignupWidgetState();
}

class _PhonesignupWidgetState extends State<PhonesignupWidget> {
  late PhonesignupModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PhonesignupModel());

    _model.emailAddressTextController ??= TextEditingController();
    _model.emailAddressFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Автоматическая верификация (если устройство автоматически получило код)
        // Можете здесь выполнить вход или сохранить учетные данные пользователя
      },
      verificationFailed: (FirebaseAuthException e) {
        // Если не удалось отправить SMS-код на указанный номер
        print('Ошибка верификации: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        // Перейдите на страницу ввода кода подтверждения, передав verificationId и phoneNumber
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EntercodeWidget(verificationId: verificationId),
          ),
        );
      },
      timeout: Duration(seconds: 60), // Время ожидания для отправки SMS-кода
      codeAutoRetrievalTimeout: (String verificationId) {  }, // Номер телефона, на который отправляется SMS-код
    );
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
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 70.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Container(
                        width: double.infinity,
                        constraints: const BoxConstraints(maxWidth: 570.0),
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: Text(
                                  'Sign Up',
                                  style: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .merge(TextStyle(
                                    fontFamily: 'Roboto',
                                  )),
                                ),
                              ),
                              TextFormField(
                                controller: _model.emailAddressTextController,
                                focusNode: _model.emailAddressFocusNode,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  hintText: '+1 123 456 7890',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color(0x00000000),
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context).primaryBackground,
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 24.0,
                                    horizontal: 16.0,
                                  ),
                                ),
                                style: FlutterFlowTheme.of(context).bodyMedium.merge(TextStyle(
                                  fontFamily: 'Roboto',
                                )),
                                keyboardType: TextInputType.phone,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 30.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    // Ваш код для отправки SMS
                                    // Здесь можно вызвать функцию, которая отправит SMS с кодом на введенный номер телефона
                                    // Например:
                                    // await _model.sendSmsVerification();
                                    // После успешной отправки, переход на экран ввода кода подтверждения
                                    String emailAddress = _model.emailAddressTextController.text;
                                    await verifyPhoneNumber(emailAddress);
                                    context.pushNamed('entercode');
                                  },
                                  text: 'Next',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 50.0,
                                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                                    color: FlutterFlowTheme.of(context).primaryColor,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall.merge(TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                    )),
                                    elevation: 3.0,
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: InkWell(
                                  onTap: () {
                                    // Ваш код для перехода на экран входа
                                    Navigator.of(context).pushNamed('sign_in');
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Already have an account? ',
                                        style: FlutterFlowTheme.of(context).bodyMedium.merge(TextStyle(
                                          fontFamily: 'Roboto',
                                        )),
                                      ),
                                      Text(
                                        'Sign In',
                                        style: FlutterFlowTheme.of(context).titleSmall.merge(TextStyle(
                                          color: FlutterFlowTheme.of(context).primaryColor,
                                          fontFamily: 'Roboto',
                                        )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
