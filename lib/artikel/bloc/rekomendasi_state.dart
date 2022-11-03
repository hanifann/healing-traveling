part of 'rekomendasi_bloc.dart';

enum RekomendasiStatus {initial, success, failure}

class RekomendasiState extends Equatable {
  
  final RekomendasiStatus status;
  final List<Rekomendasi> rekomendasi;
  final bool hasReachedMax;

  const RekomendasiState({
    this.status = RekomendasiStatus.initial, 
    this.rekomendasi = const<Rekomendasi>[], 
    this.hasReachedMax = false
  });

  RekomendasiState copyWith({
    RekomendasiStatus? status,
    List<Rekomendasi>? rekomendasi,
    bool? hasReachedMax,
  }) {
    return RekomendasiState(
      status: status ?? this.status, 
      rekomendasi: rekomendasi ?? this.rekomendasi, 
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
  
  @override
  List<Object> get props => [status, rekomendasi, hasReachedMax];
}

