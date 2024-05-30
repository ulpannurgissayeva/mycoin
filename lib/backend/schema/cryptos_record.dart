import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CryptosRecord extends FirestoreRecord {
  CryptosRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "itc" field.
  int? _itc;
  int get itc => _itc ?? 0;
  bool hasItc() => _itc != null;

  // "order" field.
  int? _order;
  int get order => _order ?? 0;
  bool hasOrder() => _order != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  bool hasPrice() => _price != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _image = snapshotData['image'] as String?;
    _itc = castToType<int>(snapshotData['itc']);
    _order = castToType<int>(snapshotData['order']);
    _price = castToType<int>(snapshotData['price']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('cryptos');

  static Stream<CryptosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CryptosRecord.fromSnapshot(s));

  static Future<CryptosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CryptosRecord.fromSnapshot(s));

  static CryptosRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CryptosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CryptosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CryptosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CryptosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CryptosRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCryptosRecordData({
  String? name,
  String? image,
  int? itc,
  int? order,
  int? price,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'image': image,
      'itc': itc,
      'order': order,
      'price': price,
    }.withoutNulls,
  );

  return firestoreData;
}

class CryptosRecordDocumentEquality implements Equality<CryptosRecord> {
  const CryptosRecordDocumentEquality();

  @override
  bool equals(CryptosRecord? e1, CryptosRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.image == e2?.image &&
        e1?.itc == e2?.itc &&
        e1?.order == e2?.order &&
        e1?.price == e2?.price;
  }

  @override
  int hash(CryptosRecord? e) => const ListEquality()
      .hash([e?.name, e?.image, e?.itc, e?.order, e?.price]);

  @override
  bool isValidKey(Object? o) => o is CryptosRecord;
}
