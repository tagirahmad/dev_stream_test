import 'package:dev_stream_test/repositories/photos_repository.dart';
import 'package:dev_stream_test/ui/screens/photo_full_screen.dart';
import 'package:dev_stream_test/ui/widgets/photos_card.dart';
import 'package:dev_stream_test/utils/global_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/photos_bloc.dart';

void main() {
  final PhotosRepository photosRepository = PhotosRepository();
  runApp(BlocProvider<PhotosBloc>(
    create: (BuildContext context) =>
        PhotosBloc(photosRepository: photosRepository)
          ..add(PhotosStartedLoading()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: GlobalConstants.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(GlobalConstants.appBarTitle),
        ),
        body: BlocBuilder<PhotosBloc, PhotosState>(
            builder: (BuildContext context, PhotosState state) {
          if (state is PhotosInProgress || state is PhotosInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PhotosSuccess) {
            return Center(
                child: GridView.builder(
                    itemCount: state.photosData.length as int,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute<void>(builder: (_) {
                              return PhotoFullScreenPage(
                                imageSrc: state.photosData[index]['urls']
                                    ['full'] as String,
                              );
                            }));
                          },
                          child: PhotosCard(state: state.photosData[index]));
                    }));
          } else {
            return const Center(
              child: Text(GlobalConstants.errorMessage),
            );
          }
        }));
  }
}