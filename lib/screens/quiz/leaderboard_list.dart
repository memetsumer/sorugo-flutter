import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/network/quiz/quiz_dao.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/firestore_pagination_listview.dart';
import '../components/firebase_error.dart';
import '../../../utils/constants.dart';
import '/screens/components/shimmer_item.dart';

class LeaderBoardWidget extends StatelessWidget {
  const LeaderBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirestoreQueryBuilder<Map<String, dynamic>>(
      pageSize: 16,
      query: QuizDao().getData(),
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
          return const Center(
            child: Text("Bilinmeyen Bir Hata Oluştu!"),
          );
        }

        if (snapshotQuery.docs.isEmpty) {
          return const Center(
            child: Text("Bilinmeyen Bir Hata Oluştu!"),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding / 2, vertical: defaultPadding),
          itemCount: snapshotQuery.docs.length,
          itemBuilder: (BuildContext context, int index) {
            if (snapshotQuery.hasMore &&
                index + 1 == snapshotQuery.docs.length) {
              snapshotQuery.fetchMore();
            }

            final Map<String, dynamic> doc = snapshotQuery.docs[index].data();

            bool isMe = doc["id"] == FirebaseAuth.instance.currentUser!.uid;

            return ListTile(
              dense: true,
              leading: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${index + 1}.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.pressStart2p(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              trailing: doc['photoUrl'] != null
                  ? CircleAvatar(
                      backgroundImage: NetworkImage(doc['photoUrl']),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.4),
                      child: FaIcon(
                        FontAwesomeIcons.user,
                        color: Colors.white.withOpacity(0.8),
                        size: 20,
                      ),
                    ),
              title: Text(
                doc['name'],
                style: GoogleFonts.pressStart2p(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              subtitle: Text(
                doc['score'].toString(),
                style: GoogleFonts.pressStart2p(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
              tileColor:
                  isMe ? Colors.amber.withOpacity(0.2) : Colors.transparent,
            );
          },
        );
      },
    );
  }
}
