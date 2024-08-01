import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:id_card_scan/features/home/home_provider.dart';
import 'package:id_card_scan/features/home/home_service.dart';
import 'package:provider/provider.dart';
import '../../../constants/image_aspect_ratio.dart';
import '../../../routes/route_constants.dart';
import '../../../widgets/loading_dialog.dart';

class CropImageWidget extends StatefulWidget {
  const CropImageWidget({super.key});

  @override
  State<CropImageWidget> createState() => _CropImageWidgetState();
}

class _CropImageWidgetState extends State<CropImageWidget> {
  final _cropController = CropController();
  @override
  Widget build(BuildContext context) {
    final homeProvider = context.read<HomeProvider>();
    final size = MediaQuery.of(context).size;
    // get current orientation
    final orientation = MediaQuery.of(context).orientation;
    final isLandscape = orientation == Orientation.landscape;

    final cardWidthTemp =
        isLandscape ? size.height : (size.width - (size.width * 0.2));
    final cardWidth = cardWidthTemp > 600 ? 600.0 : cardWidthTemp;
    final cardHeight = cardWidth / 1.586;
    final widthDiff = size.width - cardWidth;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Image'),
      ),
      body: homeProvider.selectedImage == null
          ? const Center(
              child: Text('No image selected'),
            )
          : Center(
              child: Crop(
                image: homeProvider.selectedImage!,
                baseColor: Theme.of(context).colorScheme.surface,
                controller: _cropController,

                aspectRatio: imageAspectRatio,
                initialArea: Rect.fromLTWH(
                  widthDiff + 20,
                  (size.height - cardHeight) / 1.12,
                  cardWidth + 530,
                  cardHeight + 330,
                ),
                // initialArea: Rect.fromPoints(
                //     Offset(widthDiff, (size.height - cardHeight)),
                //     Offset(widthDiff + 900, 900)),
                onCropped: (image) async {
                  showLoadingDialog(context);
                  homeProvider.setSelectedImage(null);
                  HomeService().uploadIDCard(image: image).then((_) {
                    context.pop();
                    context.push(Routes.home);
                  });
                },
              ),
            ),
      bottomNavigationBar: _cropButton(),
    );
  }

  Padding _cropButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20)
          .copyWith(bottom: 30),
      child: FilledButton(
        onPressed: () {
          _cropController.crop();
        },
        child: const Text('Crop'),
      ),
    );
  }
}
