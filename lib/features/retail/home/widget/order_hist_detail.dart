import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderHistDetail extends StatelessWidget {
  const OrderHistDetail(
      {super.key,
      required this.pic,
      required this.pname,
      required this.date,
      required this.staus,
      required this.details});
  final String pic;
  final String pname;
  final String date;
  final String staus;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ProBlackStyle().grayblackProblack,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(72, 72, 72, 0.729),
        elevation: 0.2,
        //backgroundColor: ProBlackStyle().grayblackProblack,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(
            Icons.arrow_back_ios,
            // color: ProBlackStyle().whitecloProBlack,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Booking details',
          style: TextStyle(color: Color.fromARGB(255, 242, 242, 242)),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Divider(height: 2, thickness: 2),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 18),
          child: Card(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 240, 240, 240),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(pic,
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.17,width: Get.width*0.3,),
                  ),
                  Gap(MediaQuery.of(context).size.width * 0.03),
                  Padding(
                    padding:  EdgeInsets.only(top:Get.height*0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          pname,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05),
                        ),Gap(5),

                        // Text(model.description,overflow: TextOverflow.ellipsis,maxLines: 1,)
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              details,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const Icon(
                Icons.circle,
                color: Color.fromARGB(255, 2, 143, 7),
              ),
              const Gap(5),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Booked',
                    style: TextStyle(color: Color.fromARGB(255, 19, 19, 19)),
                  ),
                  Text(
                    date,
                    // DateFormat('dd/MM/yyyy').format(DateTime.parse(date)),
                    style: TextStyle(
                        color: const Color.fromARGB(255, 196, 195, 195),
                        fontSize: MediaQuery.of(context).size.width * 0.022),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              staus == 'pl'
                  ? const Icon(
                      Icons.circle_outlined,
                      color: Color.fromARGB(255, 207, 208, 207),
                    )
                  : const Icon(
                      Icons.circle,
                      color: Color.fromARGB(255, 2, 143, 7),
                    ),
              const Gap(5),
              Column( crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Shiped',
                    style: TextStyle(color: Color.fromARGB(255, 32, 32, 32)),
                  ),
                  staus == 'pl'
                      ? Text(
                          '',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 196, 195, 195),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.022),
                        )
                      : Text(
                          '11/10/2023',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 196, 195, 195),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.022),
                        ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              staus == 'de'
                  ? const Icon(
                      Icons.circle,
                      color: Color.fromARGB(255, 2, 143, 7),
                    )
                  : const Icon(
                      Icons.circle_outlined,
                      color: Color.fromARGB(255, 204, 205, 204),
                    ),
              const Gap(5),
              const Column(
                children: [
                  Text(
                    'deleverd',
                    style: TextStyle(color: Color.fromARGB(255, 26, 26, 26)),
                  ),
                  // Text(
                  //   '1/10/2023',
                  //   style: TextStyle(
                  //       color: Color.fromARGB(255, 196, 195, 195),
                  //       fontSize:
                  //           ProBlackStyle().bappSize(context).width * 0.016),
                  // ),
                ],
              ),
            ],
          ),
        ),
        Container(
            color: const Color.fromARGB(255, 225, 224, 224),
            height: MediaQuery.of(context).size.height * 0.065,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Cancel',
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.045,
                    width: MediaQuery.of(context).size.width * 0.28,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(209, 164, 234, 138),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(child: Text('Buy more')),
                  )
                ])),
        const Divider(height: 2, thickness: 2),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'address',
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.035),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'kinfra',
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Op police station,koxikode,kerala,',
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'pin :384920',
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Ph:7890378929',
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03),
          ),
        ),
      ]),
    );
  }
}
