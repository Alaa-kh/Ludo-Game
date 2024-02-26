import 'package:flutter_application_2/core/constants/app_packages.dart';

class LudoGama extends StatelessWidget {
  const LudoGama({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: FludoGame(),
      debugShowCheckedModeBanner: false,
    );
  }
}
