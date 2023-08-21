import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_yks_app/screens/components/cached_img.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProfilePicWidget extends StatefulWidget {
  final bool edit;
  const ProfilePicWidget({
    Key? key,
    required this.edit,
  }) : super(key: key);

  @override
  State<ProfilePicWidget> createState() => _ProfilePicWidgetState();
}

class _ProfilePicWidgetState extends State<ProfilePicWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: Center(
        child: ValueListenableBuilder(
          valueListenable: Hive.box("settings").listenable(),
          builder: (context, Box box, child) {
            // var path = box.get("profilePic") as String?;

            final String? photoUrl =
                FirebaseAuth.instance.currentUser?.photoURL;

            return Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(60)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.1),
                  child: photoUrl == null
                      ? FaIcon(
                          FontAwesomeIcons.user,
                          color: Colors.white.withOpacity(0.5),
                          size: 50,
                        )
                      : CachedImg(
                          imgUrl: photoUrl,
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
