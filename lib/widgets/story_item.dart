part of '../views/detail.dart';

class StoryItem extends StatelessWidget {
  final List<Story> items;
  const StoryItem({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return items.isNotEmpty
        ? SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                return ContentCard(
                  imagePath: null,
                  imageExtension: null,
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
