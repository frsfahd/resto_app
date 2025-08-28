import 'package:resto_app/data/model/resto_brief.dart';

sealed class RestoListResultState {}

class RestoListNoneState extends RestoListResultState {}

class RestoListLoadingState extends RestoListResultState {}

class RestoListErrorState extends RestoListResultState {
  final String error;
  RestoListErrorState(this.error);
}

class RestoListLoadedState extends RestoListResultState {
  final List<RestoBrief> restoData;
  RestoListLoadedState(this.restoData);
}
