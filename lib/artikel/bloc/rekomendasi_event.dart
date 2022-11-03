part of 'rekomendasi_bloc.dart';

abstract class RekomendasiEvent extends Equatable {
  const RekomendasiEvent();

  @override
  List<Object> get props => [];
}

class RekomendasiEventFetch extends RekomendasiEvent {
  final String page;

  const RekomendasiEventFetch(this.page);
}
