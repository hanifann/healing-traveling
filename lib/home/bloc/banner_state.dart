part of 'banner_bloc.dart';

abstract class BannerState extends Equatable {
  const BannerState();
  
  @override
  List<Object> get props => [];
}

class BannerInitial extends BannerState {}

class BannerSuccess extends BannerState {
  final List<Banner> banner;

  const BannerSuccess(this.banner);
}

class BannerFailed extends BannerState {
  final String message;

  const BannerFailed(this.message);
}

class BannerLoading extends BannerState {}
