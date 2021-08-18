import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial(page: 0)) {
    add(HandlePermission());
  }

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is FaceEvent) {
      yield HomePageLoaded(currentPage: event.currentPage);
    } else if (event is HandlePermission) {
      try {
        if (await Permission.camera.request().isGranted &&
            await Permission.storage.request().isGranted &&
            await Permission.microphone.request().isGranted) {
          yield PermissionSuccess(page: state.currentPage);
        } else {
          yield PermissionFailed(page: state.currentPage);
        }
      } catch (e) {
        yield PermissionFailed(page: state.currentPage);
      }
    }
  }
}
