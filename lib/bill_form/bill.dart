import 'dart:typed_data';

class Bill {
  Uint8List? snapshot;
  double? amount;
  String? label;

  Bill({
    this.snapshot,
    this.amount,
    this.label,
  });
}
