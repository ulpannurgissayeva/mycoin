import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_coin/sendbitcoin/sendbitcoin_model.dart';
import 'package:uuid/uuid.dart';
import '../components/side_bar_nav_widget.dart';
import '../flutter_flow/flutter_flow_model.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../flutter_flow/flutter_flow_widgets.dart';
import '../flutter_flow/flutter_flow_theme.dart';

class SendbitcoinWidget extends StatefulWidget {
  @override
  _SendbitcoinWidgetState createState() => _SendbitcoinWidgetState();
}

class _SendbitcoinWidgetState extends State<SendbitcoinWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String? selectedCryptoId;
  String recipientPublicKey = '';
  double amount = 0.0;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final _unfocusNode = FocusNode();
  late SendbitcoinModel _model;
  final TextEditingController _wordsController = TextEditingController();

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SendbitcoinModel());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_unfocusNode.canRequestFocus) {
          FocusScope.of(context).requestFocus(_unfocusNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Row(
          children: [
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
            ))
              wrapWithModel(
                model: _model.sideBarNav6Model,
                updateCallback: () => setState(() {}),
                child: SideBarNavWidget(
                  oneBG: FlutterFlowTheme.of(context).primaryBackground,
                  oneIcon: Icon(
                    Icons.bar_chart_rounded,
                    color: FlutterFlowTheme.of(context).primary,
                  ),
                  twoBG: FlutterFlowTheme.of(context).secondaryBackground,
                  twoIcon: Icon(
                    Icons.school_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                  threeColor: FlutterFlowTheme.of(context).secondaryBackground,
                  threeIcon: Icon(
                    Icons.account_circle_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
              ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.attach_money,
                            size: 40,
                            color: FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Перевод',
                          style: FlutterFlowTheme.of(context).title1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(16.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButtonFormField<String>(
                                value: selectedCryptoId,
                                onChanged: (value) {
                                  setState(() {
                                    selectedCryptoId = value;
                                  });
                                },
                                items: [
                                  DropdownMenuItem(
                                    value: 'Bitcoin',
                                    child: Text('Bitcoin'),
                                  ),
                                ],
                                decoration: InputDecoration(
                                  labelText: 'Выбор валюты',
                                  border: OutlineInputBorder(),
                                ),
                                validator: (value) =>
                                value == null ? 'Please select a cryptocurrency' : null,
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                controller: _recipientController,
                                decoration: InputDecoration(
                                  labelText: 'Адрес получателя',
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    recipientPublicKey = value;
                                  });
                                },
                                validator: (value) =>
                                value == null || value.isEmpty ? 'Please enter the recipient public key' : null,
                              ),
                              SizedBox(height: 12),
                              TextFormField(
                                controller: _amountController,
                                decoration: InputDecoration(
                                  labelText: 'Сумма',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onChanged: (value) {
                                  setState(() {
                                    amount = double.tryParse(value) ?? 0.0;
                                  });
                                },
                                validator: (value) {
                                  final parsedValue = double.tryParse(value ?? '');
                                  if (parsedValue == null || parsedValue <= 0) {
                                    return 'Please enter a valid amount';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: _wordsController,
                                decoration: InputDecoration(labelText: 'Введите 10 слов'),
                                validator: (value) {
                                  if (value == null || value.isEmpty || value.split(' ').length != 10) {
                                    return 'Введите 10 слов';
                                  }
                                  return null;
                                },
                              ),
                              Spacer(),
                              FFButtonWidget(
                                onPressed: () async {
                                  if (_formKey.currentState?.validate() ?? false) {
                                    try {
                                      final String userId = FirebaseAuth.instance.currentUser!.uid;
                                      final wordsEntered = _wordsController.text.split(' ');
                                      final userData = FirebaseFirestore.instance.collection('user_words').where('user_id', isEqualTo: userId);
                                      final wor = await userData.get();
                                      final DocumentSnapshot data = wor.docs.first;
                                      final correctWords = List<String>.from(data["words"]);
                                      final bool wordsMatched = ListEquality().equals(
                                          wordsEntered, correctWords);
                                      if (!wordsMatched) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Incorrect words entered')),
                                        );
                                        return;
                                      }
                                      await transferFunds(
                                        selectedCryptoId: selectedCryptoId!,
                                        recipientPublicKey: recipientPublicKey,
                                        amount: amount,
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Transfer successful')),
                                      );
                                    } catch (e) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('Transfer failed: $e')),
                                      );
                                    }
                                  }
                                },
                                text: 'Перевести',
                                options: FFButtonOptions(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  height: 50.0,
                                  color: FlutterFlowTheme.of(context).primary,
                                  textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: FlutterFlowTheme.of(context).titleSmallFamily,
                                    color: Colors.white,
                                  ),
                                  elevation: 3.0,
                                  borderRadius: BorderRadius.circular(8.0),
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
            ),
          ],
        ),
      ),
    );
  }

  Future<void> transferFunds({
  required String selectedCryptoId,
  required String recipientPublicKey,
    required double amount,
  }) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('User not authenticated');
    }
    final fromWalletId = currentUser.uid;
    await _performTransfer(fromWalletId, recipientPublicKey, amount);
  }

  Future<void> _performTransfer(String fromUserId, String toWalletPublicKey, double amount) async {
    final fromWalletQuerySnapshot = await FirebaseFirestore.instance
        .collection('wallets')
        .where('userId', isEqualTo: fromUserId)
        .limit(1)
        .get();
    if (fromWalletQuerySnapshot.docs.isEmpty) {
      throw Exception('From wallet not found');
    }
    final fromWallet = fromWalletQuerySnapshot.docs.first;
    final toWalletQuerySnapshot = await FirebaseFirestore.instance
        .collection('wallets')
        .where('publicKey', isEqualTo: toWalletPublicKey)
        .limit(1)
        .get();
    if (toWalletQuerySnapshot.docs.isEmpty) {
      throw Exception('Recipient wallet not found');
    }
    final toWallet = toWalletQuerySnapshot.docs.first;

    final fromBalance = fromWallet['balance'] as num? ?? 0;

    if (fromBalance < amount) {
      throw Exception('Insufficient balance');
    }

    final newFromBalance = fromBalance - amount;
    final newToBalance = (toWallet['balance'] as num) + amount;

    final transactionId = Uuid().v4();
    final transactionData = {
      'fromWalletId': fromWallet.id,
      'toWalletId': toWallet.id,
      'amount': amount,
      'timestamp': DateTime.now(),
    };

    final batch = FirebaseFirestore.instance.batch();
    batch.update(fromWallet.reference, {'balance': newFromBalance});
    batch.update(toWallet.reference, {'balance': newToBalance});
    batch.set(FirebaseFirestore.instance.collection('transactions').doc(transactionId), transactionData);

    await batch.commit();
  }
}
