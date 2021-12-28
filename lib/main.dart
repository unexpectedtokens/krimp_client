import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:krimp/firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see th// application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Offset> points = [];

  void _printLoc(TapDownDetails dets) {
    var newPoints = [...points];
    newPoints.add(dets.localPosition);
    setState(() {
      points = newPoints;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(
          child: GestureDetector(
            onTapDown: _printLoc,
            child: Container(
                color: Colors.black54,
                height: MediaQuery.of(context).size.height,

                width: MediaQuery.of(context).size.width,
                child: CustomPaint(
                  painter: BackgroundPaint(
                    points: points,
                  ),
                )
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: const Text("Clear"),
        onPressed: (){
          setState(() {
            points = [];
          });
        },
      ),

    );
  }
}


class BackgroundPaint extends CustomPainter {
  final List<Offset> points;
  BackgroundPaint({
    required this.points
  });
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    // final height = size.height;
    // final width = size.width;

    Paint dotPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white70
      ..strokeWidth = 40;


    Paint linePaint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2
    ..color = Colors.redAccent;


    for (var x = 0; x < points.length; x++){
      canvas.drawCircle(points[x], 15, dotPaint);
      if (x < points.length - 1){
        canvas.drawLine(points[x], points[x + 1], linePaint);
      }
    }
    print(points);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
