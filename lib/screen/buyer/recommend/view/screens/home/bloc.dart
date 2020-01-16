import 'dart:async' show Stream;

import 'package:flutter/widgets.dart';
import 'package:flutter_ecommerce/model/Category.dart';
import 'package:rxdart/subjects.dart' show BehaviorSubject;

import 'mock.dart' as Mocks;
import 'models.dart';

class HomeBloc {
  /// onboarding
  final _subject = BehaviorSubject<bool>(seedValue: false);

  Stream<bool> get hasOnboarded => _subject.stream;

  void onboarded(bool boolean) => _subject.add(boolean);

  /// category
  final _booksSubject =
      BehaviorSubject<List<Category>>(seedValue: Mocks.categories);

  Stream<List<Category>> get books => _booksSubject.stream;

  /// scroll position
  final _scrollSubject = BehaviorSubject<double>(seedValue: 0.0);

  Stream<double> get scrollPosition => _scrollSubject.stream;

  void setScrollPosition(double value) => _scrollSubject.add(value);

  /// color
  final _colorSubject = BehaviorSubject<Color>(seedValue: Color(0xFF323CCE));

  Stream<Color> get currentColor => _colorSubject.stream;

  void setColor(ColorTransition _transition) =>
      _colorSubject.add(_transition.blendedColor);
}

///
/// provider
///
class BlocProvider extends InheritedWidget {
  final HomeBloc homeBloc;

  BlocProvider({
    Key key,
    HomeBloc homeBloc,
    Widget child,
  })  : homeBloc = homeBloc ?? HomeBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static HomeBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
          .homeBloc;
}
