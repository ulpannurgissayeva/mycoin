import 'package:firebase_auth/firebase_auth.dart';

import '../backend/schema/wallets_record.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'pricepaymenpage_widget.dart' show PricepaymenpageWidget;
import 'package:flutter/material.dart';

class PricepaymenpageModel extends FlutterFlowModel<PricepaymenpageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  String? amount; // Добавлено поле для хранения суммы пополнения
  late List<WalletsRecord> wallets; // Добавлено поле для списка кошельков
  WalletsRecord? selectedWallet; // Добавлено поле для выбранного кошелька

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
  Future<void> performPayment() async {
    // Получение данных о текущем пользователе
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Если пользователь не авторизован, выйдите из метода
      return;
    }

    // Получение данных о выбранном кошельке из dropDownValue
    final selectedWalletId = dropDownValue; // Предполагается, что это идентификатор выбранного кошелька
    final selectedAmount = textController.text; // Получение введенной суммы

    // Получение текущего баланса выбранного кошелька из Firestore
    final walletDoc = await FirebaseFirestore.instance.collection('wallets').doc(selectedWalletId).get();
    if (!walletDoc.exists) {
      // Если кошелек не найден, выйдите из метода или выведите сообщение об ошибке
      return;
    }

    // Обновление баланса выбранного кошелька в Firestore
    final currentBalance = walletDoc['balance'] ?? 0; // Получение текущего баланса
    final newBalance = currentBalance + int.tryParse(selectedAmount) ?? 0; // Пополнение баланса на введенную сумму
    await walletDoc.reference.update({'balance': newBalance}); // Обновление баланса в Firestore

    // Вывод успешного сообщения об обновлении баланса или выполнение других действий, если это необходимо
  }
}
