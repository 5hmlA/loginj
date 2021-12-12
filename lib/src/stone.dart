import 'package:flutter/widgets.dart';

class Stone extends StatelessWidget {
  final Widget child;

  const Stone({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return child;
    });
  }
}
