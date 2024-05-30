import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_coin/home_page/home_page_widget.dart';
import 'package:uuid/uuid.dart';

import '../backend/schema/wallets_record.dart';

class EntercodeWidget extends StatefulWidget {
  final String verificationId;
  const EntercodeWidget({Key? key, required this.verificationId}) : super(key: key);

  @override
  _EntercodeWidgetState createState() => _EntercodeWidgetState();
}

class _EntercodeWidgetState extends State<EntercodeWidget> {
  late String verificationId;
  late TextEditingController _smsCodeController;

  @override
  void initState() {
    super.initState();
    _smsCodeController = TextEditingController();
    verificationId = widget.verificationId;
  }

  @override
  void dispose() {
    _smsCodeController.dispose();
    super.dispose();
  }

  String generatePublicKey() {
    // Реализуйте метод генерации публичного ключа
    return 'public-key-${const Uuid().v4()}';
  }

  Future<void> _submitCode(String smsCode) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: smsCode,
      );

      final authResult = await FirebaseAuth.instance.signInWithCredential(credential);

      final user = authResult.user;
      if (user != null) {
        print('Account created successfully: ${user.uid}');
        final walletId = const Uuid().v4();
        final publicKey = generatePublicKey();
        const cryptoId = 'm3KQeye82zybAQCx2Lqe';
        final walletData = createWalletsRecordData(
          walletId: walletId,
          userId: user.uid,
          publicKey: publicKey,
          balance: 0.0,
          cryptoId: cryptoId,
        );
        final walletRecord = WalletsRecord.collection.doc(walletId);
        await walletRecord.set(walletData);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePageWidget()));
      } else {
        print('Error creating account');
      }
    } catch (e) {
      print('Error verifying the code: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Enter the verification code sent below',
              style: TextStyle(
                fontFamily: 'Plus Jakarta Sans',
                color: const Color(0xFF606A85),
                fontSize: 14.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 32.0),
            TextField(
              controller: _smsCodeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter SMS Code',
              ),
            ),
            SizedBox(height: 32.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _submitCode(_smsCodeController.text);
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
