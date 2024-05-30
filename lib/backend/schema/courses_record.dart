import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CoursesRecord extends FirestoreRecord {
  CoursesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "lessonsnumber" field.
  int? _lessonsnumber;
  int get lessonsnumber => _lessonsnumber ?? 0;
  bool hasLessonsnumber() => _lessonsnumber != null;

  // "banner" field.
  String? _banner;
  String get banner => _banner ?? '';
  bool hasBanner() => _banner != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _lessonsnumber = castToType<int>(snapshotData['lessonsnumber']);
    _banner = snapshotData['banner'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('courses');

  static Stream<CoursesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CoursesRecord.fromSnapshot(s));

  static Future<CoursesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CoursesRecord.fromSnapshot(s));

  static CoursesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CoursesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CoursesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CoursesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CoursesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CoursesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCoursesRecordData({
  String? name,
  int? lessonsnumber,
  String? banner,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'lessonsnumber': lessonsnumber,
      'banner': banner,
    }.withoutNulls,
  );

  return firestoreData;
}

class CoursesRecordDocumentEquality implements Equality<CoursesRecord> {
  const CoursesRecordDocumentEquality();

  @override
  bool equals(CoursesRecord? e1, CoursesRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.lessonsnumber == e2?.lessonsnumber &&
        e1?.banner == e2?.banner;
  }

  @override
  int hash(CoursesRecord? e) =>
      const ListEquality().hash([e?.name, e?.lessonsnumber, e?.banner]);

  @override
  bool isValidKey(Object? o) => o is CoursesRecord;
}
