part of '../views/detail.dart';

class ItemImage extends StatelessWidget {
  final String imagePath;
  final String imageExtension;
  const ItemImage({
    super.key,
    required this.imagePath,
    required this.imageExtension,
  });

  @override
  Widget build(BuildContext context) {
    String thumbnailUrl = '$imagePath.$imageExtension';

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: CachedNetworkImage(
        imageUrl: thumbnailUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }
}
