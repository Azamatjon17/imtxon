import 'package:imtxon/models/expans.dart';
import 'package:bloc/bloc.dart';
import 'package:imtxon/services/database_sql.dart';

part 'harajatlar_state.dart';
part 'harajatlar_event.dart';

class HarajatlarBloc extends Bloc<HarajatlarEvent, HarajatlarState> {
  DatabaseSql databaseSql;
  HarajatlarBloc({required this.databaseSql}) : super(InitionState()) {
    on<GetHarajatlarEvent>(getHarajatlar);
    on<AddHarajatlarEvent>(addHarajat);
    on<EditHArajatEvent>(editHarajat);
    on<DeleteHArajatEvent>(deleteHarajat);
  }

  getHarajatlar(GetHarajatlarEvent evet, Emitter<HarajatlarState> emit) async {
    emit(LodingState());
    try {
      List<Expans> harajatlar = [];
      final data = await databaseSql.get(databaseSql.harajat);
      for (var element in data) {
        harajatlar.add(Expans.formMap(element));
      }
      emit(LoadedState(harajatlar: harajatlar));
    } catch (e) {
      emit(ErorState(massage: e.toString()));
    }
  }

  addHarajat(AddHarajatlarEvent evet, Emitter<HarajatlarState> emit) async {
    emit(LodingState());
    try {
      await databaseSql.add(databaseSql.harajat, evet.expans.toMap());
      print("object");

      List<Expans> harajatlar = [];
      final data = await databaseSql.get(databaseSql.harajat);
      for (var element in data) {
        harajatlar.add(Expans.formMap(element));
      }
      emit(LoadedState(harajatlar: harajatlar));
    } catch (e) {
      emit(ErorState(massage: e.toString()));
    }
  }

  editHarajat(EditHArajatEvent evet, Emitter<HarajatlarState> emit) async {
    emit(LodingState());
    try {
      await databaseSql.edit(databaseSql.harajat, evet.expans.toMapWithId());

      List<Expans> harajatlar = [];
      final data = await databaseSql.get(databaseSql.harajat);
      for (var element in data) {
        harajatlar.add(Expans.formMap(element));
      }
      emit(LoadedState(harajatlar: harajatlar));
    } catch (e) {
      emit(ErorState(massage: e.toString()));
    }
  }

  deleteHarajat(DeleteHArajatEvent evet, Emitter<HarajatlarState> emit) async {
    emit(LodingState());
    try {
      await databaseSql.delete(databaseSql.harajat, evet.expans.id);

      List<Expans> harajatlar = [];
      final data = await databaseSql.get(databaseSql.harajat);
      for (var element in data) {
        harajatlar.add(Expans.formMap(element));
      }
      emit(LoadedState(harajatlar: harajatlar));
    } catch (e) {
      ErorState(massage: e.toString());
    }
  }
}
