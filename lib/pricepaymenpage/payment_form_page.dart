import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_coin/pricepaymenpage/pricepaymenpage_widget.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pricepaymenpage_model.dart';
export 'pricepaymenpage_model.dart';

class PaymentFormPage extends StatefulWidget {
  final String selectedWalletId;
  final int amount;

  const PaymentFormPage({
    Key? key,
    required this.selectedWalletId,
    required this.amount,
  }) : super(key: key);

  @override
  State<PaymentFormPage> createState() => _PaymentFormPageState();
}

class _PaymentFormPageState extends State<PaymentFormPage> {
  late TextEditingController _cardNumberController;
  late TextEditingController _cardNameController;
  late TextEditingController _expiryDateController;
  late TextEditingController _cvvController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _wordsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cardNumberController = TextEditingController();
    _cardNameController = TextEditingController();
    _expiryDateController = TextEditingController();
    _cvvController = TextEditingController();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardNameController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  _performPayment() async {
    if (_formKey.currentState!.validate()) {
      final String selectedWalletId = widget.selectedWalletId;
      final int amount = widget.amount;
      final String userId = FirebaseAuth.instance.currentUser!.uid;

      // Check if the words entered are correct
      final wordsEntered = _wordsController.text.split(' ');
      final userData = FirebaseFirestore.instance.collection('user_words').where('user_id', isEqualTo: userId);

      try {
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
      } catch (e) {
        print(userId);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
        return;
      }

      // Implement payment logic here
      if (selectedWalletId.isNotEmpty && amount > 0) {
        try {
          // Add transaction record
          final walletRef = FirebaseFirestore.instance.collection('wallets').where('publicKey', isEqualTo: selectedWalletId);
          final transactionRef = FirebaseFirestore.instance.collection('transactions').doc();
          final wallet = await walletRef.get();
          final DocumentSnapshot walletSnapshot = wallet.docs.first;

          if (walletSnapshot.exists) {
            await transactionRef.set({
              'fromWalletId': '',
              'toWalletId': walletSnapshot.id,
              'amount': amount,
              'timestamp': Timestamp.now(),
            });
            final walletRef1 = FirebaseFirestore.instance.collection('wallets').doc(walletSnapshot.id);
            final double balance = walletSnapshot['balance'] as double;
            await walletRef1.update({'balance': balance + amount});
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment successful')),
            );
            Navigator.popUntil(context, (route) => route.isFirst);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Payment failed')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Payment failed: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid payment details')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Форма оплаты',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: InputDecoration(labelText: 'Номер карты'),
                    keyboardType: TextInputType.number,
                    maxLength: 16, // Ограничение на количество символов
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length != 16) {
                        return 'Введите правильный номер карты';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _cardNameController,
                    decoration: InputDecoration(labelText: 'Имя Держателя карты'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Введите имя держателя карты';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _expiryDateController,
                          decoration: InputDecoration(labelText: 'Дата окончания'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Введите дату окончания';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _cvvController,
                          decoration: InputDecoration(labelText: 'CVV'),
                          keyboardType: TextInputType.number,
                          maxLength: 3, // Ограничение на количество символов
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length != 3) {
                              return 'Введите правильный CVV';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
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
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _performPayment,
                      child: Text('Пополнить'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Красный цвет кнопки
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}