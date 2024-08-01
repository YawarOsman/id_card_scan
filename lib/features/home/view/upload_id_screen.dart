import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';

class UploadIdScreen extends StatefulWidget {
  const UploadIdScreen({super.key});

  @override
  State<UploadIdScreen> createState() => _UploadIdScreenState();
}

class _UploadIdScreenState extends State<UploadIdScreen> {
  late CameraController _cameraController;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras[0], ResolutionPreset.veryHigh);
    _cameraController.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_cameraController.value.isInitialized) {
      return const SizedBox();
    }
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        // get current orientation
        final orientation = MediaQuery.of(context).orientation;
        final isLandscape = orientation == Orientation.landscape;

        final cardWidthTemp = isLandscape
            ? constraints.maxHeight
            : (constraints.maxWidth - (constraints.maxWidth * 0.2));
        final cardWidth = cardWidthTemp > 600 ? 600.0 : cardWidthTemp;
        final cardHeight = cardWidth / 1.586;

        return SizedBox(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          child: CameraPreview(
            _cameraController,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isLandscape ? 70 : 0,
                  vertical: isLandscape ? 0 : 30),
              child: Flex(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                direction: isLandscape ? Axis.horizontal : Axis.vertical,
                children: [
                  const Spacer(),
                  Container(
                    height: cardHeight,
                    width: cardWidth,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.yellow, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Capture ID card
                      // Implement capture logic here
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 70,
                      ),
                    ),
                    child: const Text('Capture'),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }
}
