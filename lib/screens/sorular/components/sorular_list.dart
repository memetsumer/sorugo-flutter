import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '/screens/components/empty_list.dart';
import '../../../models/sorular/sorular_manager.dart';
import '../../../network/soru/soru_item_dao.dart';
import '../../components/firebase_error.dart';
import '../../../utils/constants.dart';
import '/screens/sorular/soru_detail_screen.dart';
import '/screens/components/shimmer_item.dart';
import '../../components/cached_img.dart';
import '../../../utils/firestore_pagination_listview.dart';
import 'soru_list_item.dart';

class SorularList extends StatelessWidget {
  const SorularList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SorularManager>(
      builder: (context, sorularManager, child) =>
          FirestoreQueryBuilder<Map<String, dynamic>>(
        pageSize: 5,
        query: SoruDao().getData(sorularManager.getQuery),
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
              message: 'Kaydedilen soru bulunamadı!',
              img: 'assets/images/empty_list.png',
            );
          }

          if (snapshotQuery.docs.isEmpty) {
            return const EmptyListScreen(
                message: 'Kaydedilen soru bulunamadı!',
                img: 'assets/images/empty_list.png');
          }

          return RefreshIndicator(
            backgroundColor: darkBackgroundColorSecondary,
            onRefresh: () async {
              String tempQuery =
                  context.read<SorularManager>().getQueryDersName;

              context.read<SorularManager>().setQueryDersName('fvsfdv');

              await Future.delayed(
                  const Duration(milliseconds: 200),
                  () => context
                      .read<SorularManager>()
                      .setQueryDersName(tempQuery));

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
                  child: FutureBuilder(
                      future: getImage(snapshotQuery, index, context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SorularListItem(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SoruDetailScreen(
                                    urlSoru: snapshot.data! as String,
                                    soruId:
                                        snapshotQuery.docs[index].data()["id"],
                                    hasCozum: snapshotQuery.docs[index]
                                        ['hasCozum'] as bool,
                                    data: snapshotQuery.docs[index].data(),
                                  ),
                                ),
                              );
                            },
                            data: snapshotQuery.docs[index].data(),
                            idx: index,
                            isLast: (index == snapshotQuery.docs.length - 1),
                            child: snapshot.data != null
                                ? CachedImgLower(
                                    imgUrl: snapshot.data as String,
                                  )
                                : const SizedBox(),
                          );
                        } else {
                          return const ShimmerItem();
                        }
                      }),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Future<String?> getImage(query, idx, context) async {
    return await SoruDao().getSoruImage(query.docs[idx].data()["id"]);
  }
}

class SorularListKonu extends StatelessWidget {
  final String konuName;

  const SorularListKonu({
    Key? key,
    required this.konuName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SorularManager>(
      builder: (context, sorularManager, child) =>
          FirestoreQueryBuilder<Map<String, dynamic>>(
        pageSize: 5,
        query: SoruDao().getDataKonu(konuName),
        builder: (context, snapshotQuery, _) {
          if (snapshotQuery.hasError) {
            return FirebaseError(message: snapshotQuery.error.toString());
          }

          if (snapshotQuery.hasError) {
            return FirebaseError(message: snapshotQuery.error.toString());
          }

          if (snapshotQuery.isFetching == true) {
            return Padding(
                padding: const EdgeInsets.only(
                  top: defaultPadding / 2,
                  left: defaultPadding / 2,
                  right: defaultPadding / 2,
                ),
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
              message: 'Kaydedilen soru bulunamadı!',
              img: 'assets/images/empty_list.png',
            );
          }

          if (snapshotQuery.docs.isEmpty) {
            return const EmptyListScreen(
                message: 'Kaydedilen soru bulunamadı!',
                img: 'assets/images/empty_list.png');
          }

          return RefreshIndicator(
              backgroundColor: darkBackgroundColorSecondary,
              onRefresh: () async {
                String tempQuery =
                    context.read<SorularManager>().getQueryDersName;

                context.read<SorularManager>().setQueryDersName('fvsfdv');

                await Future.delayed(
                    const Duration(milliseconds: 200),
                    () => context
                        .read<SorularManager>()
                        .setQueryDersName(tempQuery));

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
                          horizontal: defaultPadding / 2,
                          vertical: defaultPadding),
                      child: FutureBuilder(
                          future: getImage(snapshotQuery, index, context),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return SorularListItem(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SoruDetailScreen(
                                        urlSoru: snapshot.data! as String,
                                        soruId: snapshotQuery.docs[index]
                                            .data()["id"],
                                        hasCozum: snapshotQuery.docs[index]
                                            ['hasCozum'] as bool,
                                        data: snapshotQuery.docs[index].data(),
                                      ),
                                    ),
                                  );
                                },
                                data: snapshotQuery.docs[index].data(),
                                idx: index,
                                isLast:
                                    (index == snapshotQuery.docs.length - 1),
                                child: snapshot.data != null
                                    ? CachedImgLower(
                                        imgUrl: snapshot.data as String,
                                      )
                                    : const SizedBox(),
                              );
                            } else {
                              return const ShimmerItem();
                            }
                          }),
                    );
                  }));
        },
      ),
    );
  }

  Future<String?> getImage(query, idx, context) async {
    return await SoruDao().getSoruImage(query.docs[idx].data()["id"]);
  }
}
