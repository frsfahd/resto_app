import 'package:equatable/equatable.dart';
import 'package:resto_app/data/model/resto_brief.dart';

sealed class RestoListResultState extends Equatable {}

class RestoListNoneState extends RestoListResultState {
  @override
  List<Object?> get props => [];
}

class RestoListLoadingState extends RestoListResultState {
  @override
  List<Object?> get props => [];
}

class RestoListErrorState extends RestoListResultState {
  final String error;

  RestoListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class RestoListLoadedState extends RestoListResultState {
  final List<RestoBrief> restoData;

  RestoListLoadedState(this.restoData);

  @override
  List<Object?> get props => [restoData];
}
