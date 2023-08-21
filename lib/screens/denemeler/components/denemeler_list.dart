import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/network/deneme/deneme_item_dao.dart';

import '../../../utils/firestore_pagination_listview.dart';
import '/screens/components/empty_list.dart';
import '../../components/firebase_error.dart';
import '../../../utils/constants.dart';
import '/screens/components/shimmer_item.dart';
import 'deneme_list_item.dart';

class DenemelerList extends StatelessWidget {
  const DenemelerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<Map<String, dynamic>>(
      pageSize: 5,
      query: DenemeDao().getData(),
      builder: (context, snapshotQuery, _) {
        if (snapshotQuery.hasError) {
          return FirebaseError(message: snapshotQuery.error.toString());
        }

        if (snapshotQuery.hasError) {
          return FirebaseError(message: snapshotQuery.error.toString());
        }

        if (snapshotQuery.isFetching == true) {
          return Padding(
              padding: const EdgeInsets.all(defaultPadding / 2),
              child: ListView(children: const [
                ShimmerItem(),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                ShimmerItem(),
                SizedBox(
                  height: defaultPadding * 2,
                ),
                ShimmerItem(),
              ]));
        }

        if (!snapshotQuery.hasData) {
          return const EmptyListScreen(
              message: "Daha deneme eklememişsin!",
              img: 'assets/images/empty_list_2.png');
        }

        if (snapshotQuery.docs.isEmpty) {
          return const EmptyListScreen(
              message: "Daha deneme eklememişsin!",
              img: 'assets/images/empty_list_2.png');
        }

        return RefreshIndicator(
          backgroundColor: darkBackgroundColorSecondary,
          onRefresh: () async {
            HapticFeedback.lightImpact();

            return Future.delayed(const Duration(milliseconds: 400));
          },
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2, vertical: defaultPadding),
            itemCount: snapshotQuery.docs.length,
            itemBuilder: (BuildContext context, int index) {
              if (snapshotQuery.hasMore &&
                  index + 1 == snapshotQuery.docs.length) {
                snapshotQuery.fetchMore();
              }

              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: defaultPadding / 2, vertical: defaultPadding),
                child: DenemeListItem(
                  isLast: index == snapshotQuery.docs.length - 1,
                  data: snapshotQuery.docs[index].data(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
