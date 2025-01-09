import 'package:block_lesson/market_place/model/cart_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product/cubit/product_cubit.dart';
import '../body/category_body.dart';
import '../body/previous_order_body.dart';
import '../body/product_body.dart';
import '../body/search_body.dart';
import '../constants/app_constans.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget buildNavBarItem(Widget icon, int index) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(height: 5),
          Text(
            'Item $index',
            style: TextStyle(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SearchBody(),
                  _text(text: "Categories"),
                  const CategoryBody(),
                  _text(text: "Previous Order"),
                  const PreviousOrderBody(),
                  _text(text: "Popular Deals"),
                ],
              ),
            ),
            const ProductBody(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 6,
        color: Colors.white,
        elevation: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavBarItem(Image.asset('images/ic_home_bottom.png'), 0),
            buildNavBarItem(Image.asset('images/ic_product_bottom.png'), 1),
            const SizedBox(width: 20),
            buildNavBarItem(Image.asset('images/ic_favorite_bottom.png'), 2),
            buildNavBarItem(Image.asset('images/ic_profile_bottom.png'), 3),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipOval(
                child: Material(
                  shape: const CircleBorder(),
                  borderOnForeground: true,
                  color: AppConstants.yellowColor,
                  elevation: 10,
                  child: InkWell(
                    child: Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        color: AppConstants.yellowColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/card_bottom_icon.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppConstants.redColor,
                child: Text(
                  "${cartData.length}",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _text({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 12, bottom: 12),
      child: Text(
        text,
        style: AppConstants.textTitle,
      ),
    );
  }
}
