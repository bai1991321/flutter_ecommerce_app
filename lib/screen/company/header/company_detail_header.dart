import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/company.dart';
import 'package:flutter_ecommerce/utils/util.dart';

class FriendDetailHeader extends StatelessWidget {
  FriendDetailHeader(
    this._company,
  );

  final Company _company;

  // Widget _buildDiagonalImageBackground(BuildContext context) {
  //   var screenWidth = MediaQuery.of(context).size.width;

  //   return new DiagonalClipper(
  //     color: const Color(0xBB8338f4),
  //   );
  // }

  Widget _buildAvatar() {
    return CircleAvatar(
      backgroundImage: new NetworkImage(_company.profile),
      radius: 50.0,
    );
  }

  Widget _buildFollowerInfo(TextTheme textTheme) {
    var followerStyle =
        textTheme.subhead.copyWith(color: const Color(0xBBFFFFFF));

    return new Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // new Text('90 Following', style: followerStyle),
          // new Text(
          //   ' | ',
          //   style: followerStyle.copyWith(
          //       fontSize: 24.0, fontWeight: FontWeight.normal),
          // ),
          new Text('100 Followers', style: followerStyle),
        ],
      ),
    );
  }

  Widget _buildActionButtons(ThemeData theme) {
    return new Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Util.uid != _company.id
          ? new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _createPillButton(
                  'INVITE ME',
                  backgroundColor: theme.accentColor,
                ),
                new DecoratedBox(
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.white30),
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  child: _createPillButton(
                    'FOLLOW',
                    textColor: Colors.white70,
                  ),
                ),
              ],
            )
          : Divider(),
    );
  }

  Widget _createPillButton(
    String text, {
    Color backgroundColor = Colors.transparent,
    Color textColor = Colors.white70,
  }) {
    return new ClipRRect(
      borderRadius: new BorderRadius.circular(30.0),
      child: new MaterialButton(
        minWidth: 140.0,
        color: backgroundColor,
        textColor: textColor,
        onPressed: () {},
        child: new Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;

    return new Stack(
      children: <Widget>[
        // _buildDiagonalImageBackground(context),
        new Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1.4,
          child: new Column(
            children: <Widget>[
              _buildAvatar(),
              _buildFollowerInfo(textTheme),
              _buildActionButtons(theme),
            ],
          ),
        ),
        new Positioned(
          top: 26.0,
          left: 4.0,
          child: new BackButton(color: Colors.white),
        ),
      ],
    );
  }
}
