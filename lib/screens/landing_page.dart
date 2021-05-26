import 'package:breaking_bad_api/bloc_characters/characters_barrel.dart';
import 'package:breaking_bad_api/bloc_quotas/quotas_barrel.dart';
import 'package:breaking_bad_api/screens/person_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:transparent_image/transparent_image.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersBloc>(context).add(CharactersRequestedEvent());

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<CharactersBloc, CharactersState>(
                    builder: (context, state) {
                  if (state is CharactersInitialState) {
                    return Text(
                      "initial",
                      style: TextStyle(fontSize: 33, color: Colors.white),
                    );
                  }
                  if (state is CharactersLoadInProgressState) {
                    return Center(
                      child: JumpingText(
                        'Loading...',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                  if (state is CharactersLoadFailureState) {
                    return Text(
                      "Load is failured",
                      style: TextStyle(fontSize: 33, color: Colors.white),
                    );
                  }
                  if (state is CharactersLoadSuccessState) {
                    final listOfChars = state.characters.characters;
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Center(
                            child: Text(
                              listOfChars[index].name.toString(),
                              style: GoogleFonts.josefinSans(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          leading: FadeInImage.memoryNetwork(
                            // width: double.infinity,
                            fit: BoxFit.contain,
                            placeholder: kTransparentImage,
                            image: listOfChars[index].img,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute<PersonScreen>(
                                    builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<QuotasBloc>(
                                              context),
                                          child: PersonScreen(
                                            person: listOfChars[index],
                                            quotasBloc:
                                                BlocProvider.of<QuotasBloc>(
                                                    context),
                                          ),
                                        )));
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(),
                      itemCount: listOfChars.length,
                    );
                    //  Text(
                    //   listOfChars[25].name,
                    //   style: TextStyle(fontSize: 33, color: Colors.white),
                    // );
                  }
                  return Container();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
