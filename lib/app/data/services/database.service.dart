import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  // Crear
  Future<void> create({
    required String path,
    required Map<String, dynamic> data
  }) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.child("${data["id"]}").set(data);
  }
  // Leer
  Future<DataSnapshot?> read({required String path}) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    final DataSnapshot snapshot = await ref.get();
    return snapshot.exists ? snapshot : null;
  }
  // Obtener 1 por ID
  Future<DataSnapshot?> getOne({required String path, required String id}) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path).child(id);
    final DataSnapshot snapshot = await ref.get();
    return snapshot.exists ? snapshot : null;
  }
  // Obtener por filtro (campo, valor)
  Future<DataSnapshot?> getBy({required String path, required String field, required String value, String dataType = 'string'}) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    final DataSnapshot snapshot = await ref.orderByChild(field).equalTo(dataType == 'number' ? int.parse(value) : value).get();
    return snapshot.exists ? snapshot : null;
  }
  // Actualizar
  Future<void> update({
    required String path,
    required Map<String, dynamic> data
  }) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.update(data);
  }
  // Actualizar
  Future<void> delete({
    required String path,
    required String id
  }) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path).child(id);
    await ref.remove();
  }

  // Obtener Cantidad de Registros
  Future<int> getQuantity({required String path}) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    final DataSnapshot snapshot = await ref.get();
    return snapshot.exists ? snapshot.children.length : 0;
  } 
}