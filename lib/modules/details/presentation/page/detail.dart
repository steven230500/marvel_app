import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:marvel_app/modules/details/presentation/bloc/bloc.dart';

part '../widgets/item_image.dart';
part '../widgets/comic_item.dart';
part '../widgets/event_item.dart';
part '../widgets/series_item.dart';
part '../widgets/story_item.dart';
part '../widgets/content_card.dart';

class DetailScreen extends StatelessWidget {
  final int characterId;
  const DetailScreen({
    super.key,
    required this.characterId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: Modular.get<DetailsBloc>()
        ..add(
          GetComics(characterId),
        )
        ..add(
          GetEvents(characterId),
        )
        ..add(
          GetSeries(characterId),
        )
        ..add(
          GetStories(characterId),
        ),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del héroe'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: BlocBuilder<DetailsBloc, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoaded) {
            return ListView(
              children: [
                const HeaderSection(title: 'Comics'),
                ComicItem(items: state.model.comics),
                const HeaderSection(title: 'Events'),
                EventItem(items: state.model.events),
                const HeaderSection(title: 'Series'),
                SeriesItem(items: state.model.series),
                const HeaderSection(title: 'Stories'),
                StoryItem(items: state.model.stories),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final String title;
  const HeaderSection({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
