import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/model/ask.dart';
import 'package:flutter_ecommerce/services/firestore_asks_service.dart';
import 'package:flutter_ecommerce/utils/form_validate.dart';
import 'package:flutter_ecommerce/utils/util.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'ask_card.dart';
import 'ask_input_fragment.dart';

class AskActiveFragment extends StatefulWidget {
  @override
  _AskActiveFragmentState createState() => _AskActiveFragmentState();
}

class _AskActiveFragmentState extends State<AskActiveFragment>
    with TickerProviderStateMixin {
  List<Ask> asks;
  AnimationController cardEntranceAnimationController;
  List<Animation> ticketAnimations;
  Animation fabAnimation;

  bool loading = true;

  @override
  void initState() {
    super.initState();
    cardEntranceAnimationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1100),
    );
    getData().then((d) {
      setState(() {
        loading = true;
      });
    });
    fabAnimation = new CurvedAnimation(
        parent: cardEntranceAnimationController,
        curve: Interval(0.7, 1.0, curve: Curves.decelerate));
    cardEntranceAnimationController.forward();
  }

  @override
  void dispose() {
    cardEntranceAnimationController.dispose();
    super.dispose();
  }

  Future<List<String>> getData() async {
    //initialize a new list
    List<String> myList = [];

    //connect to flutter jobs web site
    FirebaseFirestoreServiceAsks db = FirebaseFirestoreServiceAsks();

    db.getAskListByuID(Util.uid, 'active').listen((snapshot) {
      asks = snapshot.documents
          .map((doc_snap) => Ask.fromMap(doc_snap.data))
          .toList();
      setState(() {
        ticketAnimations = asks.map((stop) {
          int index = asks.indexOf(stop);
          double start = index * 0.1;
          double duration = 0.6;
          double end = duration + start;
          return new Tween<double>(begin: 800.0, end: 0.0).animate(
              new CurvedAnimation(
                  parent: cardEntranceAnimationController,
                  curve: new Interval(start, end, curve: Curves.decelerate)));
        }).toList();
        loading = false;
      });
    });
    // remove the first item which is the title item in the table

    print("data loaded");
    //just to wait until the get request completed
    return myList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: new Stack(
        children: <Widget>[
          Positioned.fill(
            top: MediaQuery.of(context).padding.top + 10,
            child: SingleChildScrollView(
              child: !loading
                  // ?new Column(
                  //   children:
                  ? RefreshIndicator(
                      onRefresh: () async {
                        ticketAnimations.clear();
                        asks.clear();
                        await getData();
                        setState(() {});
                      },
                      child: new Column(
                        children: ticketAnimations != null
                            ? _buildTickets().toList()
                            : <Widget>[SizedBox()],
                      ))
                  : Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.white)),
                    ),
            ),
          )
        ],
      ),
      // floatingActionButton: _buildFab(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showAskDialog() {
    // flutter defined function
    final titleKey = GlobalKey<FormState>();
    String str_title;
    Alert(
        context: context,
        title: "Project Name",
        content: Form(
          key: titleKey,
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            autofocus: true,
            maxLength: 20,
            keyboardType: TextInputType.text,
            validator: FormValidate().validateMustInput,
            onSaved: (value) => str_title = value,
          ),
        ),
        buttons: [
          new DialogButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new DialogButton(
            child: new Text("Submit"),
            onPressed: () {
              if (titleKey.currentState.validate()) {
                titleKey.currentState.save();
                Navigator.of(context).pop();
                setState(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => AskInputFragment(
                            ask_title: str_title,
                          )));
                });
              }
            },
          ),
        ]).show();
  }

  Iterable<Widget> _buildTickets() {
    return asks != null
        ? asks.map((ask) {
            int index = asks.indexOf(ask);
            return AnimatedBuilder(
              animation: cardEntranceAnimationController,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: AskCard(ask),
              ),
              builder: (context, child) => new Transform.translate(
                    offset: Offset(0.0, ticketAnimations[index].value),
                    child: child,
                  ),
            );
          })
        : null;
  }

  _buildFab() {
    return ScaleTransition(
      scale: fabAnimation,
      child: FloatingActionButton(
        backgroundColor: Colors.red,
        // onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (_) => AskInputFragment())),
        onPressed: _showAskDialog,
        child: new Icon(Icons.add),
      ),
    );
  }
}
