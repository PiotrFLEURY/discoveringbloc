import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnapshotCubit extends Cubit<Uint8List?> {
  SnapshotCubit() : super(null);

  Future<void> setSnapshot(XFile? picture) async {
    final bytes = await picture?.readAsBytes();
    emit(bytes);
  }
}
