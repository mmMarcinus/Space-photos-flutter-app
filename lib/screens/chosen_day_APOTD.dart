import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:space_pictures_app/providers/nasa_apis.dart';

class ChosenDayAPODT extends StatefulWidget {
  const ChosenDayAPODT({Key? key}) : super(key: key);

  @override
  State<ChosenDayAPODT> createState() => _ChosenDayAPODTState();
}

class _ChosenDayAPODTState extends State<ChosenDayAPODT> {
  void modalBottomDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return const DateModalBottomSheet();
        }).then((pickedDate) {
      setState(() {
        date = pickedDate;
      });
    });
  }

  //
  //
  //
  //
  //
  //  A POTEM WIDGETY :D
  //
  //
  //
  //

  DateTime? date;
  final String title = 'Date not chosen';
  @override
  Widget build(BuildContext context) {
    final apodProvider = Provider.of<NasaAPI>(context);
    String apodUrl = '';
    String apodInfo = '';
    return date == null
        ? CupertinoButton(
            child: const Text('Choose your day'),
            onPressed: () => modalBottomDatePicker(context),
          )
        : FutureBuilder(
            future: apodProvider.getAPODdata(date!).then((_) {
              apodUrl = apodProvider.apod!.imageUrl;
              apodInfo = apodProvider.apod!.imageInfo;
            }),
            builder: (ctx, asyncSnapshot) {
              return asyncSnapshot != const AsyncSnapshot.waiting()
                  ? SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          apodUrl != ''
                              ? InteractiveViewer(
                                  minScale: 0.6,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Image.network(
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
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
                                      apodUrl,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : const LinearProgressIndicator(),
                          CupertinoButton(
                            child: const Text('Choose your day'),
                            onPressed: () => modalBottomDatePicker(context),
                          ),
                        ],
                      ),
                    )
                  : Column();
            },
          );
  }
}

class DateModalBottomSheet extends StatelessWidget {
  const DateModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.now();
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Form(
          child: Container(
            height: 510.0,
            color: const Color(
                0xFF737373), //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 450,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        maximumDate: DateTime.now(),
                        initialDateTime:
                            DateTime.now().subtract(const Duration(days: 1)),
                        onDateTimeChanged: (DateTime pickedDate) {
                          date = pickedDate;
                        }),
                  ),
                  CupertinoButton.filled(
                      child: const Text('Select'),
                      onPressed: () {
                        Navigator.of(context).pop(date);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
