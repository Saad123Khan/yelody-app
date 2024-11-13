import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';

class ExtendedImageNetwork extends StatelessWidget {
  final String imageUrl;

  const ExtendedImageNetwork({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      imageUrl,
      handleLoadingProgress: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Center(
              child: CircularProgressIndicator(
                value: state.loadingProgress?.expectedTotalBytes != null
                    ? state.loadingProgress!.cumulativeBytesLoaded /
                        (state.loadingProgress!.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          case LoadState.completed:
            return null;
          case LoadState.failed:
            return Image.network(
              'assets/icons/place_holder.png', // You can provide your own error placeholder image
              fit: BoxFit.cover,
            );
        }
      },
    );
  }
}
