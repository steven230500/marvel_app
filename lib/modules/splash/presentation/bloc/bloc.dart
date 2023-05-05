import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<InitialEvent>(_onInitialEvent);
  }
  void _onInitialEvent(
    InitialEvent event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(
      const Duration(
        milliseconds: 2000,
      ),
    );

    emit(SplashLoaded());
  }
}
