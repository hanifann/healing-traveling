part of 'travel_bloc.dart';

enum TravelStatus {initial, success, failure}

class TravelState extends Equatable {
  
  final TravelStatus status;
  final List<Travel> travel;
  final bool hasReachedMax;

  const TravelState({
    this.status = TravelStatus.initial, 
    this.travel = const<Travel>[], 
    this.hasReachedMax = false
  });

  TravelState copyWith({
    TravelStatus? status,
    List<Travel>? travel,
    bool? hasReachedMax,
  }) {
    return TravelState(
      status: status ?? this.status, 
      travel: travel ?? this.travel, 
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  
  @override
  List<Object> get props => [status, travel, hasReachedMax];
}
