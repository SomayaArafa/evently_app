import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evenlyproject/firebase_utils/firestore_utility.dart';
import 'package:evenlyproject/ui/model/user_dm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../model/event_dm.dart';
import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

class EventWidget extends StatefulWidget {
  final EventDM eventDM;

  const EventWidget({super.key, required this.eventDM});

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .24,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              widget.eventDM.categoryDM.imagePath,
              fit: BoxFit.fill,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [buildDateContainer(), buildTitleContainer()],
          ),
        ],
      ),
    );
  }

  buildDateContainer() {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.offWhite,
        ),
        child: Text(
          "${widget.eventDM.dateTime.day} Jan",
          textAlign: TextAlign.start,
          style: AppTextStyles.blue14SemiBold,
        ),
      ),
    );
  }

  buildTitleContainer() => Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.offWhite,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.eventDM.title,
                style: AppTextStyles.blue14SemiBold,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection(UserDM.collectionName)
                  .doc(UserDM.currentUser!.id)
                  .snapshots(),
              builder: (context, snapshot) {
                return InkWell(
                    onTap: () {
                      if (UserDM.currentUser!.favoriteEvents
                          .contains(widget.eventDM.id)) {
                        removeEventFromFavorite(
                            widget.eventDM.id, UserDM.currentUser!);
                      } else {
                        addEventToFavorite(
                            widget.eventDM.id, UserDM.currentUser!);
                      }
                    },
                    child: Icon(
                      UserDM.currentUser!.favoriteEvents
                              .contains(widget.eventDM.id)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.blue,
                    ));
              },
            ),
          ],
        ),
      );
}
