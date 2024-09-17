part of 'harajatlar_bloc.dart';

sealed class HarajatlarEvent {}

class GetHarajatlarEvent extends HarajatlarEvent {}

class AddHarajatlarEvent extends HarajatlarEvent {
  Expans expans;
  AddHarajatlarEvent({required this.expans});
}

class EditHArajatEvent extends HarajatlarEvent {
  Expans expans;
  EditHArajatEvent({required this.expans});
}

class DeleteHArajatEvent extends HarajatlarEvent {
  Expans expans;
  DeleteHArajatEvent({required this.expans});
}
