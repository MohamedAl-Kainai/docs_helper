import 'package:pdf/widgets.dart';

class CellWidget extends StatelessWidget {
  String text;
  double width;

  CellWidget({required this.text, required this.width});

  @override
  Widget build(context) {
    return Container(
        alignment: Alignment.center,
        width: this.width,
        height: 15,
        child: Text(this.text, style: TextStyle(fontSize: 7)));
  }
}
