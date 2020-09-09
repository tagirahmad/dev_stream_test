part of 'photos_bloc.dart';

@immutable
abstract class PhotosEvent {}

class PhotosStartedLoading extends PhotosEvent {}
