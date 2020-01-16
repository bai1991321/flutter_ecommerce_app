import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_ecommerce/model/ask.dart';
import 'package:flutter_ecommerce/screen/buyer/Asks/ask_detail/ask_detail_page.dart';
import 'package:intl/intl.dart';

class AskCard extends StatelessWidget {
  final Ask _ask;

  const AskCard(this._ask);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AskClipper(10.0),
      child: Material(
        elevation: 4.0,
        shadowColor: Color(0x30E5E5E5),
        color: Colors.transparent,
        child: ClipPath(
            clipper: AskClipper(12.0),
            child: InkWell(
              child: Card(
                elevation: 0.0,
                margin: const EdgeInsets.all(2.0),
                child: _buildCardContent(),
              ),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => AskDetailPage(_ask))),
            )),
      ),
    );
  }

  Container _buildCardContent() {
    return Container(
      height: 104.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(_ask.ask_title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20.0)),
              Divider(),
              Text(
                  'Creted date: ' +
                      DateFormat.yMMMd().format(DateTime.parse(_ask.created_date
                          .replaceAll(' ', 'T')
                          .replaceAll(':', '')
                          .replaceAll('-', ''))),
                  style: TextStyle(color: Colors.blueAccent)),
            ],
          ),
          Material(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(24.0),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _ask.status,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )))
        ],
      ),
    );
  }
}

class AskClipper extends CustomClipper<Path> {
  final double radius;

  AskClipper(this.radius);

  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.addOval(
        Rect.fromCircle(center: Offset(0.0, size.height / 2), radius: radius));
    path.addOval(Rect.fromCircle(
        center: Offset(size.width, size.height / 2), radius: radius));
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
