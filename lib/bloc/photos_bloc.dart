import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dev_stream_test/repositories/photos_repository.dart';
import 'package:meta/meta.dart';

part 'photos_event.dart';
part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  PhotosBloc({@required this.photosRepository})
      : assert(photosRepository != null),
        super(PhotosInitial());
  final PhotosRepository photosRepository;

  @override
  Stream<PhotosState> mapEventToState(
    PhotosEvent event,
  ) async* {
    if (event is PhotosStartedLoading) {
      yield PhotosInProgress();
      try {
        final String rawPhotosData = await photosRepository.getPhotos();
        final dynamic resp = jsonDecode(rawPhotosData);
        yield PhotosSuccess(photosData: resp);
      } catch (e) {
        yield PhotosLoadingFailure(error: e.toString());
      }
    }
  }
}
