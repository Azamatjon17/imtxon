part of 'daromad_bloc.dart';

sealed class DaromadlarState {}

class InitionDaromadState extends DaromadlarState {}

class LodingDarmoadState extends DaromadlarState {}

class ErorDaromadState extends DaromadlarState {
  String massage;
  ErorDaromadState({required this.massage});
}

class LoadedDaromadState extends DaromadlarState {
  List<Expans> daromadlar;
  LoadedDaromadState({required this.daromadlar});
}
