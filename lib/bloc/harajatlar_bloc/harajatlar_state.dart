part of 'harajatlar_bloc.dart';

sealed class HarajatlarState {}

class InitionState extends HarajatlarState {}

class LodingState extends HarajatlarState {}

class ErorState extends HarajatlarState {
  String massage;
  ErorState({required this.massage});
}

class LoadedState extends HarajatlarState {
  List<Expans> harajatlar;
  LoadedState({required this.harajatlar});
}
