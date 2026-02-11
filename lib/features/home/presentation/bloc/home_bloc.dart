import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_bloc.dart';
import '../../../../core/bloc/base_state.dart';
import '../../domain/usecases/get_services_usecase.dart';
import '../../domain/usecases/create_service_usecase.dart';
import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(this._getServices, this._createService) : super(const HomeState()) {
    on<HomeLoadServices>(_onLoad);
    on<HomeCreateService>(_onCreate);
  }

  final GetServicesUseCase _getServices;
  final CreateServiceUseCase _createService;

  Future<void> _onLoad(HomeLoadServices event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: const BaseState.loading()));
    try {
      final services = await _getServices();
      emit(state.copyWith(status: BaseState.success(services)));
    } catch (e) {
      emit(state.copyWith(status: const BaseState.failure('Load services failed')));
    }
  }

  Future<void> _onCreate(HomeCreateService event, Emitter<HomeState> emit) async {
    await _createService(event.service);
    add(const HomeLoadServices());
  }
}
