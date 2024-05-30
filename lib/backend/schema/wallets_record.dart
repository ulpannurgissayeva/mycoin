import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:my_coin/flutter_flow/flutter_flow_util.dart';
import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

class WalletsRecord extends FirestoreRecord {
  WalletsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  String? _walletId;
  String get walletId => _walletId ?? '';
  bool hasWalletId() => _walletId != null;

  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  String? _publicKey;
  String get publicKey => _publicKey ?? '';
  bool hasPublicKey() => _publicKey != null;

  double? _balance;
  double get balance => _balance ?? 0.0;
  bool hasBalance() => _balance != null;

  String? _cryptoId;
  String get cryptoId => _cryptoId ?? '';
  bool hasCryptoId() => _cryptoId != null;

  void _initializeFields() {
    _walletId = snapshotData['walletId'] as String?;
    _userId = snapshotData['userId'] as String?;
    _publicKey = snapshotData['publicKey'] as String?;
    _balance = castToType<double>(snapshotData['balance']);
    _cryptoId = snapshotData['cryptoId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('wallets');

  static Stream<WalletsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => WalletsRecord.fromSnapshot(s));

  static Future<WalletsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => WalletsRecord.fromSnapshot(s));

  static WalletsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      WalletsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static WalletsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      WalletsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'WalletsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is WalletsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createWalletsRecordData({
  String? walletId,
  String? userId,
  String? publicKey,
  double? balance,
  String? cryptoId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'walletId': walletId,
      'userId': userId,
      'publicKey': publicKey,
      'balance': balance,
      'cryptoId': cryptoId,
    }.withoutNulls,
  );

  return firestoreData;
}

class WalletsRecordDocumentEquality implements Equality<WalletsRecord> {
  const WalletsRecordDocumentEquality();

  @override
  bool equals(WalletsRecord? e1, WalletsRecord? e2) {
    return e1?.walletId == e2?.walletId &&
        e1?.userId == e2?.userId &&
        e1?.publicKey == e2?.publicKey &&
        e1?.balance == e2?.balance &&
        e1?.cryptoId == e2?.cryptoId;
  }

  @override
  int hash(WalletsRecord? e) => const ListEquality().hash([
        e?.walletId,
        e?.userId,
        e?.publicKey,
        e?.balance,
        e?.cryptoId,
      ]);

  @override
  bool isValidKey(Object? o) => o is WalletsRecord;
}


