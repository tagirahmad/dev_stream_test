import 'package:flutter/material.dart';

class PhotoFullScreenPage extends StatefulWidget {
  const PhotoFullScreenPage({@required this.imageSrc});
  final String imageSrc;

  @override
  _PhotoFullScreenPageState createState() => _PhotoFullScreenPageState();
}

class _PhotoFullScreenPageState extends State<PhotoFullScreenPage>
    with TickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    /*animation.addStatusListener((status) {
    if (status == AnimationStatus.completed) {
      controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      controller.forward();
    }
  });*/
//this will start the animation
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Dismissible(
          onDismissed: (DismissDirection direction) {
            Navigator.pop(context);
          },
          direction: DismissDirection.vertical,
          key: UniqueKey(),
          child: Center(
            child: Image.network(
              widget.imageSrc,
              fit: BoxFit.fitWidth,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) {
                  return FadeTransition(opacity: animation, child: child);
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
            ),
          )),
    );
  }
}
