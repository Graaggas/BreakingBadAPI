import 'package:breaking_bad_api/models/person/person_barrel.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class RandomPerson extends StatelessWidget {
  const RandomPerson({Key? key, required this.person}) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 5,
      width: double.infinity,
      // color: Colors.white12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.network(
                person.img,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: JumpingText(
                      'Loading...',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 20,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    Text('Some errors occurred!'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
