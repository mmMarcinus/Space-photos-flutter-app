import 'package:flutter/material.dart';

class APODWidget extends StatefulWidget {
  String apodUrl;
  String apodInfo;
  APODWidget(this.apodUrl, this.apodInfo, {Key? key}) : super(key: key);

  @override
  State<APODWidget> createState() => _APODWidgetState();
}

class _APODWidgetState extends State<APODWidget> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'ASTRONOMY PICTURE OF THE DAY:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black87),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: widget.apodUrl.length > 2
                          ? InteractiveViewer(
                              minScale: 0.6,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Image.network(
                                  widget.apodUrl,
                                  fit: BoxFit.fill,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: LinearProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : const CircularProgressIndicator(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(widget.apodInfo),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          );
        } else {
          return SafeArea(
              child: InteractiveViewer(
            minScale: 0.6,
            child: Container(
              width: double.infinity,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Image.network(
                widget.apodUrl,
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: LinearProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ));
        }
      },
    );
  }
}
