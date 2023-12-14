import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(143, 148, 251, 1),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(

            /// mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                width: 200,
                child: Card(
                  elevation: 4.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.network(
                          'https://assets-global.website-files.com/5e9ebc3fff165933f19fbdbe/61b31c9d289e22335b6753b2_Ice%20Cream%202.jpg',
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [
                        //       Text(
                        //         'productName',
                        //         style: TextStyle(
                        //           fontSize: 18.0,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //       SizedBox(height: 8.0),
                        //       Text(
                        //         'productDetails',
                        //         style: TextStyle(
                        //           fontSize: 14.0,
                        //           color: Colors.grey,
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              const Text(
                'Product Name',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 208, 208, 207)),
              ),
              const Text(
                'Milk is a nutrient-rich liquid food produced by the mammary glands of mammals. It is the primary source of nutrition for infant mammals before they are able to digest other types of food. The early lactation milk is known as colostrum, and carries the mother\'s antibodies to the baby. It contains many other nutrients including protein and lactose. It is a key component in numerous food products like butter, cream, yogurt, and cheese.',
                style: TextStyle(color: Color.fromARGB(255, 57, 57, 57),fontSize: 16),
              )
            ]),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          // Add functionality for button tap here
          if (kDebugMode) {
            print('Order button tapped');
          }
        },
        child: Container(
          width: 120,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color.fromARGB(67, 6, 233, 14)
                .withOpacity(0.6), // Green with transparency
          ),
          child: const Center(
            child: Text(
              'Order',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color
              ),
            ),
          ),
        ),
      ),
    );
  }
}
