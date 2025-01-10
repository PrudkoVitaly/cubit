import 'package:flutter/material.dart';

import '../../../../market_place/constants/app_constans.dart';

class PreviousOrderBody extends StatelessWidget {
  const PreviousOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildOrderContainer(context),
      ],
    );
  }

  Widget _buildOrderContainer(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: _containerDecoration(),
      child: Row(
        children: [
          Expanded(child: _buildOrderDetails()),
          _buildRotatedDiscountBanner(),
        ],
      ),
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
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
    );
  }

  Widget _buildOrderDetails() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOrderStatus(),
          const SizedBox(height: 10),
          _buildProductImages(),
          const SizedBox(height: 10),
          _buildOrderSummary(),
        ],
      ),
    );
  }

  Widget _buildOrderStatus() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Delivered",
          style: TextStyle(
            color: AppConstants.greenColor,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "On Wed, 27 Jul 2022",
          style: TextStyle(
            color: AppConstants.textSmallColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildProductImages() {
    return Container(
      width: double.infinity,
      height: 63,
      decoration: BoxDecoration(
        color: AppConstants.greyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 10),
            width: 50,
            height: 50,
            color: Colors.grey[300], // Placeholder for product images
          );
        },
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Row(
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order ID : #28292999",
              style: TextStyle(
                color: AppConstants.textSmallColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Final Total : ₹ 123",
              style: TextStyle(
                color: AppConstants.textSmallColor,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
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
          onPressed: () {
            // Handle "Order Again" action
          },
        ),
      ],
    );
  }

  Widget _buildRotatedDiscountBanner() {
    return Align(
      alignment: Alignment.centerRight,
      child: RotatedBox(
        quarterTurns: -1,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          decoration: const BoxDecoration(
            color: AppConstants.greenColor,
            borderRadius: BorderRadius.only(),
          ),
          child: const Text(
            'Order Again & Get Flat 10% OFF',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}