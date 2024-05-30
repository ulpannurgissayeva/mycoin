import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

class TransactionsRecord extends FirestoreRecord {
  TransactionsRecord._(
      super.reference,
      super.data,
      ) {
    _initializeFields();
  }

  String? _transactionId;
  String get transactionId => _transactionId ?? '';
  bool hasTransactionId() => _transactionId != null;

  String? _fromWalletId;
  String get fromWalletId => _fromWalletId ?? '';
  bool hasFromWalletId() => _fromWalletId != null;

  String? _toWalletId;
  String get toWalletId => _toWalletId ?? '';
  bool hasToWalletId() => _toWalletId != null;

  double? _amount;
  double get amount => _amount ?? 0.0;
  bool hasAmount() => _amount != null;

  DateTime? _timestamp;
  DateTime? get timestamp => _timestamp;
  bool hasTimestamp() => _timestamp != null;

  String? _cryptoId;
  String get cryptoId => _cryptoId ?? '';
  bool hasCryptoId() => _cryptoId != null;

  void _initializeFields() {
    _transactionId = snapshotData['transactionId'] as String?;
    _fromWalletId = snapshotData['fromWalletId'] as String?;
    _toWalletId = snapshotData['toWalletId'] as String?;
    _amount = castToType<double>(snapshotData['amount']);
    _timestamp = snapshotData['timestamp'] as DateTime?;
    _cryptoId = snapshotData['cryptoId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('transactions');

  static Stream<TransactionsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TransactionsRecord.fromSnapshot(s));

  static Future<TransactionsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TransactionsRecord.fromSnapshot(s));

  static TransactionsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      TransactionsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TransactionsRecord getDocumentFromData(
      Map<String, dynamic> data,
      DocumentReference reference,
      ) =>
      TransactionsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TransactionsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TransactionsRecord &&
          reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTransactionsRecordData({
  String? transactionId,
  String? fromWalletId,
  String? toWalletId,
  double? amount,
  DateTime? timestamp,
  String? cryptoId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'transactionId': transactionId,
      'fromWalletId': fromWalletId,
      'toWalletId': toWalletId,
      'amount': amount,
      'timestamp': timestamp,
      'cryptoId': cryptoId,
    }.withoutNulls,
  );

  return firestoreData;
}

class TransactionsRecordDocumentEquality implements Equality<TransactionsRecord> {
  const TransactionsRecordDocumentEquality();

  @override
  bool equals(TransactionsRecord? e1, TransactionsRecord? e2) {
    return e1?.transactionId == e2?.transactionId &&
        e1?.fromWalletId == e2?.fromWalletId &&
        e1?.toWalletId == e2?.toWalletId &&
        e1?.amount == e2?.amount &&
        e1?.timestamp == e2?.timestamp &&
        e1?.cryptoId == e2?.cryptoId;
  }

  @override
  int hash(TransactionsRecord? e) => const ListEquality().hash([
    e?.transactionId,
    e?.fromWalletId,
    e?.toWalletId,
    e?.amount,
    e?.timestamp,
    e?.cryptoId,
  ]);

  @override
  bool isValidKey(Object? o) => o is TransactionsRecord;
}
