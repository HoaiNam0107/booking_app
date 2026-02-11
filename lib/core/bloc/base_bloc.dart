// lib/core/bloc/base_bloc.dart
import 'dart:developer' as talker;

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBloc<E, S> extends Bloc<E, S> {
  BaseBloc(super.initialState) {
    on<E>((event, emit) async {
      talker.log('📦 EVENT → $event');
    });
  }

  @override
  void onChange(Change<S> change) {
    super.onChange(change);
    talker.log('🔄 STATE → ${change.nextState}');
  }
}
