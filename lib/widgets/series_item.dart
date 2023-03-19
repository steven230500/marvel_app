part of '../views/detail.dart';

class SeriesItem extends StatelessWidget {
  final List<Series> items;
  const SeriesItem({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return items.isNotEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                return ContentCard(
                  imagePath: item.thumbnailPath,
                  imageExtension: item.thumbnailExtension,
                  title: item.title,
                );
              },
            ),
          )
        : const Center(
            child: Text(
              'No hay registros',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
