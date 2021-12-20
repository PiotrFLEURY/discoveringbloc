import 'dart:typed_data';

import 'package:discoveringbloc/bill_form/bill.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillCubit extends Cubit<Bill> {
  BillCubit() : super(Bill());

  // set snapshot
  void setSnapshot(Uint8List snapshot) {
    state.snapshot = snapshot;
    emit(state);
  }

  // set amout
  void setAmount(double amount) {
    state.amount = amount;
    emit(state);
  }

  // set label
  void setLabel(String label) {
    state.label = label;
    emit(state);
  }
}
