part of 'daromad_bloc.dart';

sealed class DaromadlarEvent {}

class GetDaromadlarEvent extends DaromadlarEvent {}

class AddDaromadlarEvent extends DaromadlarEvent {
  Expans expans;
  AddDaromadlarEvent({required this.expans});
}

class EditDaromadEvent extends DaromadlarEvent {
  Expans expans;
  EditDaromadEvent({required this.expans});
}

class DeleteDaromadEvent extends DaromadlarEvent {
  Expans expans;
  DeleteDaromadEvent({required this.expans});
}
