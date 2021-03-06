import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:popular_cities/repositories/preferences_repository.dart';

part 'preferences_event.dart';
part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> 
{

  final Preferences _preferences;

  PreferencesBloc({@required Preferences preferences})
    : assert(preferences != null),
    _preferences = preferences, super(PreferencesNotLoaded());


  @override
  Stream<PreferencesState> mapEventToState(
    PreferencesEvent event,
  ) async* {
   if(event is LoadPreferences)
   {
     yield* _mapLoadPreferencesToState();
   }
  }

  Stream<PreferencesState> _mapLoadPreferencesToState() async*
  {
    Firebase.initializeApp();
    final bool first = (await _preferences.isFirstTime());

    yield PreferencesLoaded(first);
  }

}
