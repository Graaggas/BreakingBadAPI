import 'dart:async';
import 'dart:math';

import 'package:breaking_bad_api/bloc_quotas/quotas_barrel.dart';
import 'package:breaking_bad_api/repositories/quotes_repo.dart';
import 'package:breaking_bad_api/screens/person_screen.dart';
import 'package:breaking_bad_api/screens/random_person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breaking_bad_api/bloc_people/blocs_barrel.dart';
import 'package:breaking_bad_api/bloc_people/people_bloc_observer.dart';
import 'package:breaking_bad_api/repositories/api_client.dart';
import 'package:breaking_bad_api/repositories/people_repo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'bloc_quotas/quotes_bloc_observer.dart';

void main() {
  Bloc.observer = PeopleBlocObsever();
  Bloc.observer = QuotasBlocObserver();

  final PeopleRepo peopleRepo = PeopleRepo(
    apiClient: APIClient(httpClient: http.Client()),
  );

  final QuotesRepo quotesRepo = QuotesRepo(
    apiClient: APIClient(httpClient: http.Client()),
  );

  runApp(MyApp(
    peopleRepo: peopleRepo,
    quotesRepo: quotesRepo,
  ));
}

class MyApp extends StatelessWidget {
  final PeopleRepo peopleRepo;
  final QuotesRepo quotesRepo;

  MyApp({
    Key? key,
    required this.peopleRepo,
    required this.quotesRepo,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PeopleBloc(peopleRepo: peopleRepo),
          ),
          BlocProvider(
            create: (context) => QuotasBloc(quotesRepo: quotesRepo),
          ),
        ],
        child: LandingPage(),
      ),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PeopleBloc>(context).add(PeopleRequestedEvent(id: 7));

    return SafeArea(
      child: BlocBuilder<PeopleBloc, PeopleState>(
        builder: (context, state) {
          if (state is PeopleInitialState) {
            return Center(
              child: Text(
                "Initial",
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            );
          }
          if (state is PeopleLoadInProgressState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PeopleLoadSuccessState) {
            final people = state.people;
            return PersonScreen(people: people);
          }
          return Container();
        },
      ),
    );
  }
}

// class OneTest extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Random rand;
//     rand = new Random();
//     int id;
//     Timer.periodic(Duration(seconds: 15), (timer) {
//       rand = new Random();
//       id = rand.nextInt(55) + 1;
//       BlocProvider.of<PeopleBloc>(context).add(PeopleRequestedEvent(id: id));
//     });

//     // BlocProvider.of<PeopleBloc>(context).add(PeopleRequestedEvent(id: 1));
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             BlocBuilder<PeopleBloc, PeopleState>(
//               builder: (context, state) {
//                 if (state is PeopleLoadSuccessState) {
//                   return RandomPerson(person: state.people);
//                 } else {
//                   return Container();
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TwoTest extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton(
//           child: Icon(Icons.search),
//           onPressed: () {
//             BlocProvider.of<PeopleBloc>(context)
//                 .add(PeopleRequestedEvent(id: 9));
//           },
//         ),
//         body: Center(
//           child: BlocBuilder<PeopleBloc, PeopleState>(
//             builder: (context, state) {
//               if (state is PeopleInitialState) {
//                 return Center(
//                   child: Text(
//                     "Initial",
//                     style: TextStyle(fontSize: 16, color: Colors.white70),
//                   ),
//                 );
//               }
//               if (state is PeopleLoadInProgressState) {
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//               if (state is PeopleLoadSuccessState) {
//                 final people = state.people;
//                 return Column(
//                   children: [
//                     Image.network(
//                       people.img,
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, loadingProgress) {
//                         if (loadingProgress == null) return child;
//                         return CircularProgressIndicator();
//                       },
//                       errorBuilder: (context, error, stackTrace) =>
//                           Text('Some errors occurred!'),
//                     ),
//                     Center(
//                       child: Text(
//                         "${people.name}",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.white70,
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               }
//               if (state is PeopleLoadFailureState) {
//                 return Text("Failure");
//               } else
//                 return Container();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
