part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  final int currentPage;

  HomePageState({@required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

class MaskLoading extends HomePageState {
  MaskLoading({@required int page}) : super(currentPage: page);
}

class HomePageInitial extends HomePageState {
  HomePageInitial({@required int page}) : super(currentPage: page);
}

class HomePageLoaded extends HomePageState {
  final int currentPage;

  HomePageLoaded({@required this.currentPage})
      : super(currentPage: currentPage);

  @override
  List<Object> get props => [currentPage];
}

class PermissionFailed extends HomePageState {
  PermissionFailed({int page}) : super(currentPage: page);
}

class PermissionSuccess extends HomePageState {
  PermissionSuccess({int page}) : super(currentPage: page);
}
