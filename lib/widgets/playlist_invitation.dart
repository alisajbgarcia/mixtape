import 'package:flutter/material.dart';
import 'package:mixtape/utilities/colors.dart';

class PlaylistInvitation extends StatelessWidget {
  const PlaylistInvitation({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Popup example'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        new ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
