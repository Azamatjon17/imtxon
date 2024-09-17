import 'package:imtxon/models/expans.dart';

import 'package:bloc/bloc.dart';
import 'package:imtxon/services/database_sql.dart';

part 'daromad_event.dart';
part 'daromad_state.dart';

class DaromadBloc extends Bloc<DaromadlarEvent, DaromadlarState> {
  DatabaseSql databaseSql;
  DaromadBloc({required this.databaseSql}) : super(InitionDaromadState()) {
    on<GetDaromadlarEvent>(getdaromadlar);
    on<AddDaromadlarEvent>(addDaromad);
    on<EditDaromadEvent>(editDaromad);
    on<DeleteDaromadEvent>(deleteDaromad);
  }

  getdaromadlar(GetDaromadlarEvent evet, Emitter<DaromadlarState> emit) async {
    emit(LodingDarmoadState());
    try {
      List<Expans> daromadlar = [];
      final data = await databaseSql.get(databaseSql.daromad);
      for (var element in data) {
        daromadlar.add(Expans.formMap(element));
      }
      emit(LoadedDaromadState(daromadlar: daromadlar));
    } catch (e) {
      emit(ErorDaromadState(massage: e.toString()));
    }
  }

  addDaromad(AddDaromadlarEvent evet, Emitter<DaromadlarState> emit) async {
    emit(LodingDarmoadState());
    try {
      await databaseSql.add(databaseSql.daromad, evet.expans.toMap());

      List<Expans> daromadlar = [];
      final data = await databaseSql.get(databaseSql.daromad);
      for (var element in data) {
        daromadlar.add(Expans.formMap(element));
      }
      emit(LoadedDaromadState(daromadlar: daromadlar));
    } catch (e) {
      emit(ErorDaromadState(massage: e.toString()));
    }
  }

  editDaromad(EditDaromadEvent evet, Emitter<DaromadlarState> emit) async {
    emit(LodingDarmoadState());
    try {
      await databaseSql.edit(databaseSql.daromad, evet.expans.toMapWithId());

      List<Expans> daromadlar = [];
      final data = await databaseSql.get(databaseSql.daromad);
      for (var element in data) {
        daromadlar.add(Expans.formMap(element));
      }
      emit(LoadedDaromadState(daromadlar: daromadlar));
    } catch (e) {
      emit(ErorDaromadState(massage: e.toString()));
    }
  }

  deleteDaromad(DeleteDaromadEvent evet, Emitter<DaromadlarState> emit) async {
    emit(LodingDarmoadState());
    try {
      await databaseSql.delete(databaseSql.daromad, evet.expans.id);

      List<Expans> daromadlar = [];
      final data = await databaseSql.get(databaseSql.daromad);
      for (var element in data) {
        daromadlar.add(Expans.formMap(element));
      }
      emit(LoadedDaromadState(daromadlar: daromadlar));
    } catch (e) {
      ErorDaromadState(massage: e.toString());
    }
  }
}
