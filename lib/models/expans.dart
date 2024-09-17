import 'dart:ffi';

class Expans {
  int id;
  double summa;
  String kategory;
  DateTime createdDate;
  String discription;
  Expans({
    required this.id,
    required this.summa,
    required this.kategory,
    required this.discription,
    required this.createdDate,
  });

  factory Expans.formMap(Map<String, Object?> data) {
    return Expans(
      id: data['id'] as int,
      summa: data['summa'] as double,
      kategory: data['kategory'] as String,
      discription: data['discription'] as String,
      createdDate: DateTime.parse(data['createdDate'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'summa': summa,
      'kategory': kategory,
      'discription': discription,
      'createdDate': createdDate.toIso8601String(),
    };
  }

  Map<String, dynamic> toMapWithId() {
    return {
      'id': id,
      'summa': summa,
      'kategory': kategory,
      'discription': discription,
      'createdDate': createdDate.toIso8601String(),
    };
  }
}
