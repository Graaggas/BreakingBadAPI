import 'package:breaking_bad_api/bloc_characters/characters_barrel.dart';
import 'package:breaking_bad_api/bloc_quotas/quotas_barrel.dart';
import 'package:breaking_bad_api/misc/consts.dart';
import 'package:breaking_bad_api/models/person/person_barrel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:transparent_image/transparent_image.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({Key? key, required this.person}) : super(key: key);

  final Person person;

  @override
  _PersonScreenState createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  bool _isBio = true;

  @override
  Widget build(BuildContext context) {
    List<String> nameForQuoteRes = widget.person.name.split(" ");
    String nameForQuote = "${nameForQuoteRes[0]}+${nameForQuoteRes[1]}";

    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Title'),
        // ),
        body: Container(
          color: Colors.white,
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Stack(
                  children: [
                    FadeInImage.memoryNetwork(
                      width: double.infinity,
                      fit: BoxFit.fitWidth,
                      placeholder: kTransparentImage,
                      image: widget.person.img,
                    ),

                    // Image.network(
                    //   people.img,
                    //   width: double.infinity,
                    //   fit: BoxFit.fitWidth,
                    // ),
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
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 32.0,
                          right: 32.0,
                          bottom: 16.0,
                          top: 16.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isBio = true;
                                });
                              },
                              child: _isBio
                                  ? Text(
                                      "Bio",
                                      style: GoogleFonts.josefinSans(
                                        decoration: TextDecoration.underline,
                                        color: kColorBackAndAliveInfo,
                                        fontSize: 24,
                                      ),
                                    )
                                  : Text(
                                      "Bio",
                                      style: GoogleFonts.josefinSans(
                                        color: kColorPersonNameInPanel,
                                        fontSize: 24,
                                      ),
                                    ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isBio = false;
                                  BlocProvider.of<QuotasBloc>(context).add(
                                      QuotasRequestedEvent(
                                          author: nameForQuote));

                                  BlocProvider.of<CharactersBloc>(context)
                                      .add(CharactersRequestedEvent());
                                });
                              },
                              child: _isBio
                                  ? Text(
                                      "Quotes",
                                      style: GoogleFonts.josefinSans(
                                        color: kColorPersonNameInPanel,
                                        fontSize: 24,
                                      ),
                                    )
                                  : Text(
                                      "Quotes",
                                      style: GoogleFonts.josefinSans(
                                        decoration: TextDecoration.underline,
                                        color: kColorBackAndAliveInfo,
                                        fontSize: 24,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      _isBio
                          ? Column(
                              children: [
                                buildFields(
                                    fieldName: "Nickname",
                                    dataField: widget.person.nickname),
                                buildFields(
                                    fieldName: "Date of Birth",
                                    dataField: widget.person.birthday),
                                buildFields(
                                    fieldName: "Actor",
                                    dataField: widget.person.portrayed),
                                buildFields(
                                    fieldName: "Occupation",
                                    dataArrayField: widget.person.occupation),
                              ],
                            )
                          : Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: BlocBuilder<QuotasBloc, QuotasState>(
                                builder: (context, state) {
                                  if (state is QuotasInitialState) {
                                    return Center(
                                      child: Text(
                                        "Initial",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white70),
                                      ),
                                    );
                                  }
                                  if (state is QuotasLoadInProgressState) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (state is QuotasLoadSuccessState) {
                                    final quote = state.quotes;
                                    return ListView.builder(
                                        itemCount: quote.length,
                                        physics: ScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return Text(
                                            "- " + quote[index].quote + "\n",
                                            style: GoogleFonts.josefinSans(
                                              color: kColorPersonNameInPanel,
                                              fontSize: 24,
                                            ),
                                          );
                                        });
                                    // Text(
                                    //   "- " + quote[1].quote,
                                    //   style: GoogleFonts.josefinSans(
                                    //     color: kColorPersonNameInPanel,
                                    //     fontSize: 24,
                                    //   ),
                                    // );
                                  }
                                  return Container();
                                },
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding buildFields(
      {required String fieldName,
      String? dataField,
      List<String>? dataArrayField}) {
    if (dataArrayField == null && dataField == null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: 32.0,
        right: 32.0,
        bottom: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: AutoSizeText(
              "$fieldName:",
              style: GoogleFonts.josefinSans(
                color: kColorPersonNameInPanel,
                fontSize: 24,
              ),
              minFontSize: 10,
              maxLines: 1,
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 10,
            ),
          ),
          dataArrayField == null
              ? Expanded(
                  child: AutoSizeText(
                    "${dataField!}",
                    style: GoogleFonts.josefinSans(
                      color: Colors.black87,
                      fontSize: 24,
                    ),
                    minFontSize: 10,
                    maxLines: 2,
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: dataArrayField.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return AutoSizeText(
                          dataArrayField[index],
                          minFontSize: 18,
                          maxLines: 2,
                          style: GoogleFonts.josefinSans(
                            color: Colors.black87,
                            fontSize: 24,
                          ),
                        );
                      }),
                ),
        ],
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
                widget.person.name,
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
                widget.person.status,
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
