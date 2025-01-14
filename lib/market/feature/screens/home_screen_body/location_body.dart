import 'package:flutter/material.dart';

import '../../../../market_place/constants/app_constans.dart';

class LocationBody extends StatefulWidget {
  const LocationBody({super.key,});

  @override
  State<LocationBody> createState() => _LocationBodyState();
}

class _LocationBodyState extends State<LocationBody> {
  @override
  Widget build(BuildContext context) {
    Locale _locale = Locale('en', '');

    void _changeLanguage(String languageCode) {
      setState(() {
        _locale = Locale(languageCode);
      });
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Hyper',
                      style: TextStyle(
                        color: AppConstants.yellowColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    TextSpan(
                      text: 'Mart',
                      style: TextStyle(
                        color: AppConstants.greenColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  // Выбор языка
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Text("S.of(context).hello"),  // Локализованное слово
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         _changeLanguage('en');  // Переключение на английский
                  //       },
                  //       child: Text('Change to English'),
                  //     ),
                  //     ElevatedButton(
                  //       onPressed: () {
                  //         _changeLanguage('ru');  // Переключение на русский
                  //       },
                  //       child: Text('Change to Russian'),
                  //     ),
                  //   ],
                  // ),
                  const Icon(Icons.keyboard_arrow_down, size: 20),
                  const SizedBox(width: 16),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: AppConstants.greenColor,
                radius: 24,
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              // Текст с локацией
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Bengaluru',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'BTM Layout, 500628',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
