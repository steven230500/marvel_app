import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:marvel_app/app/config/config.dart';
import 'package:marvel_app/models/marvel.dart';
import 'package:marvel_app/modules/home/presentation/bloc/bloc.dart';
import 'package:marvel_app/modules/details/presentation/page/detail.dart';

part '../widgets/see_more.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<MarvelHeroesBloc>()
        ..add(
          GetDataHeroes(),
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
        title: const Text('Marvel Heroes'),
      ),
      body: BlocBuilder<MarvelHeroesBloc, MarvelHeroesState>(
        builder: (context, state) {
          if (state is MarvelHeroesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: CachedNetworkImage(
                        imageUrl:
                            '${state.model.heroes[index].thumbnail.path}.${state.model.heroes[index].thumbnail.extension}',
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SeeMore(
                    heroe: state.model.heroes[index],
                  ),
                ],
              );
            },
            itemCount: state.model.heroes.length,
            viewportFraction: 1.0,
            scale: 1.0,
            control: const SwiperControl(color: Colors.white),
            onIndexChanged: (int currentIndex) {
              if (currentIndex == state.model.heroes.length - 1) {
                Modular.get<MarvelHeroesBloc>().add(GetDataHeroes());
              }
            },
          );
        },
      ),
    );
  }
}
