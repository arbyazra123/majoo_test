import 'package:flutter/material.dart';
import 'package:majootestcase/ui/extra/custom_drawer.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final Function()? retry;
  final Color? textColor;
  final double fontSize;
  final double gap;
  final Widget? retryButton;

  const ErrorScreen(
      {Key? key,
      this.gap = 10,
      this.retryButton,
      this.message = "",
      this.fontSize = 14,
      this.retry,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Majoo Test",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(fontSize: 12, color: textColor ?? Colors.black),
            ),
            retry != null
                ? Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      retryButton ??
                          IconButton(
                            onPressed: () {
                              if (retry != null) retry!();
                            },
                            icon: Icon(Icons.refresh_sharp),
                          ),
                    ],
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
