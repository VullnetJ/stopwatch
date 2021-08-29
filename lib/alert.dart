import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Alert {
  final String title;
  final String message;

  const Alert({
    required this.title, required this.message
  }): assert(title !=null),
    assert(message != null);


  void show(BuildContext context) {
    final platform = Theme.of(context).platform;

    if (platform == TargetPlatform.iOS) {
      _buildCupertinoAlert(context);
    } else {
      _buildMaterialAlert(context);
    }
  }
  void _buildMaterialAlert(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: Text('Close'))
          ],
        );
      }
    );
  }
  void _buildCupertinoAlert(BuildContext context) {
    showCupertinoDialog(
      context: context, 
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            CupertinoButton(
              child: Text('Close'), 
              onPressed: () => Navigator.of(context).pop()),
          ],
        );
      });
  }

}