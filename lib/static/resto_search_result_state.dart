import 'package:resto_app/data/model/resto_brief.dart';

sealed class RestoSearchResultState {}

class RestoSearchNoneState extends RestoSearchResultState {}

class RestoSearchLoadingState extends RestoSearchResultState {}

class RestoSearchErrorState extends RestoSearchResultState {
  final String error;
  RestoSearchErrorState(this.error);
}

class RestoSearchLoadedState extends RestoSearchResultState {
  final List<RestoBrief> restoData;
  RestoSearchLoadedState(this.restoData);
}
