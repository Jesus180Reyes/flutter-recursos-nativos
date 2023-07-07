import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:miselaneos_app/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
    );
  }
}
