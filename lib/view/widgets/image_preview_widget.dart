import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.5),
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.5),
          leading: BackButton(
            color: Colors.white,
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    // Get.back();
                  },
                  child: DismissiblePage(
                    backgroundColor: Colors.transparent,

                    onDismissed: () {
                      Navigator.of(context).pop();
                    },
                    onDragEnd: () {
                      Get.back();
                    },
                    // Note that scrollable widget inside DismissiblePage might limit the functionality
                    // If scroll direction matches DismissiblePage direction
                    direction: DismissiblePageDismissDirection.multi,
                    isFullScreen: true,
                    child: Hero(
                      tag: 'image',
                      child: CachedNetworkImage(
                        imageUrl: image,
                        fit: BoxFit.fitWidth,
                      ),

                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
