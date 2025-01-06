import 'package:flutter/material.dart';

import '../constants/app_constans.dart';

class PreviousOrderBody extends StatelessWidget {
  const PreviousOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.2),
            blurRadius: 40,
            spreadRadius: 0,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Delivered",
                    style: TextStyle(
                      color: AppConstants.greenColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Text(
                    "On Wed, 27 Jul 2022",
                    style: TextStyle(
                      color: AppConstants.textSmallColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // List of products in the order
                  Container(
                    width: double.infinity,
                    height: 63,
                    decoration: BoxDecoration(
                      color: AppConstants.greyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: 3,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(right: 10),
                          width: 50,
                          height: 50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order ID : #28292999",
                            style: TextStyle(
                                color: AppConstants.textSmallColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Final Total : ₹ 123",
                            style: TextStyle(
                                color: AppConstants.textSmallColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.greenColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Order Again",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 30,
            color: Colors.red,
            padding: const EdgeInsets.all(2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: "OrderAgain&".split("").map((char) {
                return Text(
                  char,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
