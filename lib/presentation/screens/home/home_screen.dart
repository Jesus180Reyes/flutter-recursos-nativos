import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miselaneos_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: const Text("Miselaneos"),
                    actions: [
                      IconButton(
                        onPressed: () {
                          context.push("/permissions");
                        },
                        icon: const Icon(
                          Icons.settings,
                        ),
                      ),
                    ],
                  ),
                  const MainMenu(),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.red,
            width: double.infinity,
            height: 100,
          ),
        ],
      ),
    );
  }
}
