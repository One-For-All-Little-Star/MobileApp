import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlphabetRoadMap extends StatelessWidget {
  const AlphabetRoadMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/alphabet_background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage("assets/images/panel.png"),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.circular(10)),
          child: Card(
              color: Colors.transparent,
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Card(
                        margin: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SizedBox(
                              width: 80,
                              height: 80,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffdb4c00),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const Text(
                                        "A",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                      Row(
                                        children: const [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 24,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 24,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: 24,
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                            )
                          ],
                        ))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
