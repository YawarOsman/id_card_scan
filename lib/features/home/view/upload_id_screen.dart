import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_scan/routes/route_constants.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import '../home_provider.dart';

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
      appBar: AppBar(
        title: const Text('Upload ID'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        // get current orientation
        final orientation = MediaQuery.of(context).orientation;
        final isLandscape = orientation == Orientation.landscape;

        final cardWidthTemp = isLandscape
            ? constraints.maxHeight
            : (constraints.maxWidth - (constraints.maxWidth * 0.2));
        final cardWidth = cardWidthTemp > 600 ? 600.0 : cardWidthTemp;
        final cardHeight = cardWidth / 1.586;

        return Center(
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
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () async {
                      pushRoute() {
                        context.push(Routes.cropImage);
                      }

                      final homeProvider = context.read<HomeProvider>();
                      final xFile = await _cameraController.takePicture();
                      final image = await xFile.readAsBytes();
                      homeProvider.setSelectedImage(image);
                      pushRoute();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 13,
                        horizontal: 20,
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
