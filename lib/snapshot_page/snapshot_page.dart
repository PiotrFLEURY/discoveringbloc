import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:discoveringbloc/bill_form/bill_cubit.dart';
import 'package:discoveringbloc/bill_form/bill_form.dart';
import 'package:discoveringbloc/snapshot_page/snapshot_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SnapshotPage extends StatefulWidget {
  const SnapshotPage({Key? key}) : super(key: key);

  @override
  State<SnapshotPage> createState() => _SnapshotPageState();
}

class _SnapshotPageState extends State<SnapshotPage> {
  List<CameraDescription> cameras = [];
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    _initCameras();
  }

  Future<void> _initCameras() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }
    return BlocProvider(
      create: (context) => SnapshotCubit(),
      child: BlocBuilder<SnapshotCubit, Uint8List?>(
        builder: (context, snapshot) {
          bool hasSnapshot = snapshot != null;
          return SafeArea(
            child: Scaffold(
              body: hasSnapshot
                  ? _ValidateSnapshot(snapshot: snapshot)
                  : CameraPreview(controller!),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: hasSnapshot
                  ? null
                  : FloatingActionButton(
                      child: const Icon(Icons.camera),
                      onPressed: () async {
                        try {
                          final file = await controller?.takePicture();
                          context.read<SnapshotCubit>().setSnapshot(file);
                        } on CameraException catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}

class _ValidateSnapshot extends StatelessWidget {
  final Uint8List snapshot;

  const _ValidateSnapshot({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Image.memory(snapshot),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _RoundIconButton(
                color: Colors.red,
                icon: Icons.close,
                onPressed: () {
                  context.read<SnapshotCubit>().setSnapshot(null);
                },
              ),
              _RoundIconButton(
                color: Colors.green,
                icon: Icons.check,
                onPressed: () {
                  context.read<BillCubit>().setSnapshot(snapshot);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const BillForm(),
                    ),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const _RoundIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Material(
        elevation: 8,
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(48)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(48)),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
