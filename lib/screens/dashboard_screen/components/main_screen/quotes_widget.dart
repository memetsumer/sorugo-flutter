import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/network/quotes/quotes_dao.dart';
import 'package:flutter_yks_app/screens/dashboard_screen/components/main_screen/quote.dart';
import 'package:flutter_yks_app/utils/constants.dart';

class QuotesWidget extends StatelessWidget {
  const QuotesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: QuotesDao().getQuotes(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData && snapshot.data!.docs.isNotEmpty
              ? QuoteWidget(
                  quotes: snapshot.data!.docs
                      .map((e) => e.data() as Map<String, dynamic>)
                      .toList())
              : const SizedBox(
                  height: defaultPadding * 2,
                );
        });
  }
}
