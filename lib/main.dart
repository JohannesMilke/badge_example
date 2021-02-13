import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Badges';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          primaryColor: Colors.red,
        ),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int countFavourites = 97;
  int countMessages = 7;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        bottomNavigationBar: buildBottomBar(),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Badge(
                  padding: EdgeInsets.all(8),
                  toAnimate: false,
                  badgeContent: Text(
                    '$countFavourites',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: buildButton(
                    text: 'Increase Favourites',
                    onClicked: () => setState(() => countFavourites += 1),
                  ),
                ),
                const SizedBox(height: 32),
                Badge(
                  padding: EdgeInsets.all(8),
                  toAnimate: false,
                  badgeColor: Colors.orange,
                  shape: BadgeShape.square,
                  position: BadgePosition.topStart(),
                  //showBadge: false,
                  badgeContent: Text(
                    '$countMessages',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: buildButton(
                    text: 'Increase Messages',
                    onClicked: () => setState(() => countMessages += 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget buildButton({
    @required String text,
    @required VoidCallback onClicked,
  }) =>
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: onClicked,
      );

  Widget buildBottomBar() => BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: buildCustomBadge(
              counter: countFavourites,
              child: Icon(Icons.favorite_border),
            ),
            title: Text('Favourites'),
          ),
          BottomNavigationBarItem(
            icon: buildCustomBadge(
              counter: countMessages,
              child: Icon(Icons.message),
            ),
            title: Text('Messages'),
          ),
        ],
        onTap: (int index) {},
      );
}

Widget buildCustomBadge({
  @required int counter,
  @required Widget child,
}) {
  final text = counter.toString();
  final deltaFontSize = (text.length - 1) * 3.0;

  return Stack(
    overflow: Overflow.visible,
    children: [
      child,
      Positioned(
        top: -6,
        right: -20,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 10,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16 - deltaFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ],
  );
}
