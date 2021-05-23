import 'package:breaking_bad_api/misc/consts.dart';
import 'package:breaking_bad_api/models/peoples/people_barrel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({Key? key, required this.people}) : super(key: key);

  final People people;

  @override
  Widget build(BuildContext context) {
    print("width = ${MediaQuery.of(context).size.width}");
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Title'),
        // ),
        body: SingleChildScrollView(
          child: Column(
            //* stretch отвечает за растягивание объекта! Важно для растягивания мелких картинок до ширины экрана. Если в потомках будет FittedBox - вызовет ошибку.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                children: [
                  Image.network(people.img),
                  Positioned(
                    bottom: 0,
                    child: buildFormWithName(context),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "list with Bio and Quotas",
                      style: TextStyle(color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "name: ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          "Answer ",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack buildFormWithName(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        CustomPaint(
          size: Size(
              MediaQuery.of(context).size.width,
              (MediaQuery.of(context).size.width * 0.25)
                  .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
          painter: RPSCustomPainter(),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                people.name,
                style: GoogleFonts.josefinSans(
                  color: kColorPersonNameInPanel,
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                people.status,
                style: GoogleFonts.josefinSans(
                  color: kColorBackAndAliveInfo,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 255, 255, 255)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.5000000);
    path_0.quadraticBezierTo(size.width * 0.0000250, size.height * 0.2063000,
        size.width * 0.0250000, size.height * 0.1000000);
    path_0.quadraticBezierTo(size.width * 0.0500000, size.height * 0.0125000,
        size.width * 0.1250000, 0);
    path_0.lineTo(size.width * 0.8750000, 0);
    path_0.quadraticBezierTo(size.width * 0.9507750, size.height * 0.0032000,
        size.width * 0.9750000, size.height * 0.1000000);
    path_0.quadraticBezierTo(size.width * 1.0039000, size.height * 0.2062000,
        size.width, size.height * 0.5000000);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.5000000);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
