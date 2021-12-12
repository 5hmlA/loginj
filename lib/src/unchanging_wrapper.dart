import 'package:flutter/widgets.dart';

class Unchanging extends StatelessWidget {
  final Widget child;

  const Unchanging({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return child;
    });
  }
}
