
import 'package:flutter/material.dart';

import '../../../../../firebase_utils/firestore_utility.dart';
import '../../../../model/event_dm.dart';
import '../../../../model/user_dm.dart';
import '../../../../widgets/event_widget.dart';

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFavoriteEventsForUser(UserDM.currentUser!.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          var events = snapshot.data!;
          // events.where((event){
          //   return UserDM.currentUser!.favoriteEventIds.contains(event.id);
          // });
          return Expanded(
            child: Column(children: [buildEventsList(events)]),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  buildEventsList(List<EventDM> events) {
    return Expanded(
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventWidget(eventDM: events[index]);
        },
      ),
    );
  }
}