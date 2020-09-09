part of 'photos_bloc.dart';

@immutable
abstract class PhotosState {}

class PhotosInitial extends PhotosState {}

class PhotosInProgress extends PhotosState {}

class PhotosSuccess extends PhotosState {
  PhotosSuccess({@required this.photosData});
  final dynamic photosData;
}

class PhotosLoadingFailure extends PhotosState {
  PhotosLoadingFailure({@required this.error});
  final String error;
}
