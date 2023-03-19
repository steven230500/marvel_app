part of '../views/home.dart';

class SeeMore extends StatelessWidget {
  final MarvelCharacter heroe;
  const SeeMore({super.key, required this.heroe});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              heroe.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                elevation: MaterialStateProperty.all<double>(0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      characterId: heroe.id,
                    ),
                  ),
                );
              },
              child: const Text('Ver más'),
            ),
          ],
        ),
      ),
    );
  }
}
