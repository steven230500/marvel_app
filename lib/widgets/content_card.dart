part of '../views/detail.dart';

class ContentCard extends StatelessWidget {
  final String? imagePath;
  final String? imageExtension;
  final String title;

  const ContentCard({
    Key? key,
    this.imagePath,
    this.imageExtension,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imagePath != null && imageExtension != null)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                child: ItemImage(
                  imagePath: imagePath!,
                  imageExtension: imageExtension!,
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
