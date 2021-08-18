part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FaceEvent extends HomePageEvent {
  final int currentPage;

  FaceEvent({@required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

class HandlePermission extends HomePageEvent{}
