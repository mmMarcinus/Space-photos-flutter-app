import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:space_pictures_app/providers/nasa_apis.dart';

class ChosenDayAPODTSCreen extends StatefulWidget {
  static const routeName = '/chosenDayAPOD';

  ChosenDayAPODTSCreen({Key? key}) : super(key: key);

  @override
  State<ChosenDayAPODTSCreen> createState() => _ChosenDayAPODTSCreenState();
}

class _ChosenDayAPODTSCreenState extends State<ChosenDayAPODTSCreen> {
  void modalBottomDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return DateModalBottomSheet();
        }).then((pickedDate) {
      setState(() {
        date = pickedDate;
      });
    });
  }

  DateTime? date = null;
  final String title = 'Date not chosen';
  @override
  Widget build(BuildContext context) {
    final apodProvider = Provider.of<NasaAPI>(context);
    String apodUrl = '';
    String apodInfo = '';
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text(title),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
          Widget>[
        CupertinoButton(
          child: Text('Choose your day'),
          onPressed: () => modalBottomDatePicker(context),
        ),
        Spacer(
          flex: 1,
        ),
        date == null
            ? Text(
                'You dint choose your day yet!',
                textAlign: TextAlign.center,
              )
            : FutureBuilder(
                future: apodProvider.getAPODdata(date!).then((_) {
                  apodUrl = apodProvider.apod!.imageUrl;
                  apodInfo = apodProvider.apod!.imageInfo;
                  //print(apodUrl);
                }),
                builder: (ctx, asyncSnapshot) {
                  print(apodUrl);
                  return asyncSnapshot == AsyncSnapshot.waiting()
                      ? CircularProgressIndicator()
                      : apodUrl != ''
                          ? Container(
                              height: MediaQuery.of(context).size.height - 120,
                              child: InteractiveViewer(
                                minScale: 0.6,
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Image.network(
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
                                    apodUrl,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            )
                          : LinearProgressIndicator();
                }),
        Spacer(
          flex: 3,
        ),
      ]),
    );
  }
}

class DateModalBottomSheet extends StatelessWidget {
  const DateModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime _date = DateTime.now();
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
                  Container(
                    height: 450,
                    child: CupertinoDatePicker(
                        mode: CupertinoDatePickerMode.date,
                        maximumDate: DateTime.now(),
                        initialDateTime:
                            DateTime.now().subtract(const Duration(days: 1)),
                        onDateTimeChanged: (DateTime pickedDate) {
                          _date = pickedDate;
                        }),
                  ),
                  CupertinoButton.filled(
                      child: Text('Select'),
                      onPressed: () {
                        Navigator.of(context).pop(_date);
                      }),
                ],
              ),
              // child: Column(
              //   mainAxisSize: MainAxisSize.min,
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: <Widget>[

              //   ],
              // ),
            ),
          ),
        ),
      ),
    );
  }
}

// class LoginModalBottomSheet extends State<LoginModalBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
    
//   }
// }
