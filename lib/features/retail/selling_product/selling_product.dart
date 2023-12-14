import 'package:flutter/material.dart';

class SellingProduct extends StatelessWidget {
  const SellingProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Column(children: [
       Expanded(
            child: GridView.count(
              childAspectRatio: 1 / 1,
              crossAxisCount: 4, // Number of columns
              children: List.generate(10, (index) {
                // Generating a list of 10 containers
                return index == 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.15,
                          color: const Color.fromARGB(255, 230, 230, 230),
                          child: const Center(child: Icon(Icons.add)),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          width: MediaQuery.of(context).size.width * 0.15,
                          color: const Color.fromARGB(255, 94, 88, 88),
                          child: Image.network(
                            'https://assets-global.website-files.com/5e9ebc3fff165933f19fbdbe/61b31c9d289e22335b6753b2_Ice%20Cream%202.jpg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
              }),
            ),
          ),
    ]),);
  }
}