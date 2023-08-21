import 'package:flutter/material.dart';
import '/screens/sorular/components/sorular_category.dart';
import 'components/konular_kind_category.dart';
import 'components/sorular_list.dart';

// import 'components/sorular_list.dart';

class SorularScreen extends StatelessWidget {
  const SorularScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Soruların", style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
        backgroundColor: Colors.transparent,
      ),
      body: const Column(
        children: [
          SorularCategory(),
          KonuKindCategory(),
          Expanded(
            child: SorularList(),
          ),
        ],
      ),
    );
  }
}
