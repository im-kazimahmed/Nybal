import 'package:flutter/material.dart';

class ConnectionLostScreen extends StatelessWidget {
  const ConnectionLostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/no_internet.png",
            fit: BoxFit.cover,
          ),
          const Text(
            "No internet connection\nPlease check your internet connection",
            style: TextStyle(
              color: Color(0xFF6371AA),
              fontSize: 20,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          // Container(
          //   decoration: BoxDecoration(
          //     boxShadow: [
          //       BoxShadow(
          //         offset: const Offset(0, 5),
          //         blurRadius: 25,
          //         color: const Color(0xFF59618B).withOpacity(0.17),
          //       ),
          //     ],
          //   ),
          //   child: MaterialButton(
          //     color: const Color(0xFF6371AA),
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(50)),
          //     onPressed: () {
          //
          //     },
          //     child: Text(
          //       "retry".toUpperCase(),
          //       style: const TextStyle(color: Colors.white),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}