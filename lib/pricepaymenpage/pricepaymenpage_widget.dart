import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'payment_form_page.dart'; // Импортируем страницу формы оплаты
import 'package:google_fonts/google_fonts.dart';
import 'pricepaymenpage_model.dart';
export 'pricepaymenpage_model.dart';

class PricepaymenpageWidget extends StatefulWidget {
  const PricepaymenpageWidget({Key? key}) : super(key: key);

  @override
  State<PricepaymenpageWidget> createState() => _PricepaymenpageWidgetState();
}

class _PricepaymenpageWidgetState extends State<PricepaymenpageWidget> {
  late PricepaymenpageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PricepaymenpageModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  // _performPayment(String selectedWalletId, int amount) async {
  //   // Implement payment logic here
  //
  //   // Example code to insert transaction and update wallet balance
  //   final String userId = FirebaseAuth.instance.currentUser!.uid;
  //   final String selectedWalletId = _model.dropDownValue ?? '';
  //   final int amount = int.tryParse(_model.textController?.text ?? '') ?? 0;
  //
  //   if (selectedWalletId.isNotEmpty && amount > 0) {
  //     try {
  //       // Add transaction record
  //       final transactionRef = FirebaseFirestore.instance.collection('transactions').doc();
  //       await transactionRef.set({
  //         'transactionId': transactionRef.id,
  //         'fromWalletId': '',
  //         'toWalletId': selectedWalletId,
  //         'amount': amount,
  //         'timestamp': Timestamp.now(),
  //       });
  //
  //       // Update wallet balance
  //       final walletRef = FirebaseFirestore.instance.collection('wallets').where('publicKey', isEqualTo: selectedWalletId);
  //       final wallet = await walletRef.get();
  //       final DocumentSnapshot walletSnapshot = wallet.docs.first;
  //       if (walletSnapshot.exists) {
  //         final walletRef1 = FirebaseFirestore.instance.collection('wallets').doc(walletSnapshot.id);
  //         final double balance = walletSnapshot['balance'] as double;
  //         await walletRef1.update({'balance': balance + amount});
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Payment successful')),
  //         );
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text('Payment failed')),
  //         );
  //       }
  //
  //     } catch (e) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Payment failed: $e')),
  //       );
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Invalid payment details')),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _model.unfocusNode.canRequestFocus
        ? FocusScope.of(context).requestFocus(_model.unfocusNode)
        : FocusScope.of(context).unfocus(),
    child: Scaffold(
    key: scaffoldKey,
    backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
    appBar: responsiveVisibility(
    context: context,
    tabletLandscape: false,
    desktop: false,
    )
    ? AppBar(
    backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
    automaticallyImplyLeading: false,
    title: Text(
    'Балансты толтыру',
    style: FlutterFlowTheme.of(context).headlineMedium.override(
    fontFamily: FlutterFlowTheme.of(context).headlineMediumFamily,
    letterSpacing: 0.0,
    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).headlineMediumFamily),
    ),
    ),
    actions: const [],
    centerTitle: false,
    elevation: 0.0,
    )
        : null,
    body: SafeArea(
    top: true,
    child: Column(
    mainAxisSize: MainAxisSize.max,
    children: [
    Align(
    alignment: const AlignmentDirectional(0.0, 0.0),
    child: Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(14.0, 20.0, 14.0, 14.0),
    child: Container(
    width: 900.0,
    height: 474.0,
    decoration: BoxDecoration(
    color: FlutterFlowTheme.of(context).secondaryBackground,
    borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 70.0),
    child: Text(
    'Пополнение кошелька',
    textAlign: TextAlign.center,
    style: FlutterFlowTheme.of(context).bodyMedium.override(
    fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
    fontSize: 24.0,
    letterSpacing: 0.0,
    useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
    ),
    ),
    ),
    StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('wallets')
        .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const CircularProgressIndicator();
    } else if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
    } else {
    final List<DocumentSnapshot> documents = snapshot.data!.docs;
    final List<String> walletNames = documents.map((e) => e['publicKey'] as String).toList();
    return Padding(
    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 30.0),
    child: FlutterFlowDropDown<String>(
    controller: _model.dropDownValueController ??= FormFieldController<String>(null),
    options: walletNames,
    onChanged: (val) => setState(() => _model.dropDownValue = val),
    width: 600.0,
    height: 56.0,
    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
      fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
      letterSpacing: 0.0,
      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
    ),
      hintText: 'Выберите кошелек',
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: FlutterFlowTheme.of(context).secondaryText,
        size: 24.0,
      ),
      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
      elevation: 2.0,
      borderColor: FlutterFlowTheme.of(context).alternate,
      borderWidth: 2.0,
      borderRadius: 8.0,
      margin: const EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
      hidesUnderline: true,
      isOverButton: true,
      isSearchable: false,
      isMultiSelect: false,
    ),
    );
    }
    },
    ),
      Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
        child: SizedBox(
          width: 600.0,
          child: TextFormField(
            controller: _model.textController,
            focusNode: _model.textFieldFocusNode,
            autofocus: true,
            textCapitalization: TextCapitalization.none,
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Сумма пополнение',
              labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                letterSpacing: 0.0,
                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
              ),
              hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                fontFamily: FlutterFlowTheme.of(context).labelMediumFamily,
                letterSpacing: 0.0,
                useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).alternate,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).primary,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: FlutterFlowTheme.of(context).error,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: FlutterFlowTheme.of(context).bodyMediumFamily,
              letterSpacing: 0.0,
              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
            ),
            keyboardType: TextInputType.number,
            validator: (value) => _model.textControllerValidator?.call(context, value),
          ),
        ),
      ),
    ],
    ),
    ),
    ),
    ),
      FFButtonWidget(
        onPressed: () async {
// Navigate to PaymentFormPage
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentFormPage(
                selectedWalletId: _model.dropDownValue ?? '',
                amount: int.tryParse(_model.textController?.text ?? '') ?? 0,
              ),
            ),
          );
// Check if payment was successful and update balance if needed
          if (result == true) {

          }
        },
        text: 'Пополнить',
        options: FFButtonOptions(
          width: 500.0,
          height: 50.0,
          padding: const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
          iconPadding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
          color: FlutterFlowTheme.of(context).primary,
          textStyle: FlutterFlowTheme.of(context).titleSmall.override(
            fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
            color: Colors.white,
            letterSpacing: 0.0,
            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleSmallFamily),
          ),
          elevation: 3.0,
          borderSide: const BorderSide(
            color: Colors.transparent,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
          hoverColor: FlutterFlowTheme.of(context).success,
        ),
      ),
    ],
    ),
    ),
    ),
    );
  }
}
