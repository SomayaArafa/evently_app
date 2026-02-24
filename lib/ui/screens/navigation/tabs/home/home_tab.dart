import 'package:evenlyproject/ui/screens/edit%20and%20update/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../firebase_utils/firestore_utility.dart';
import '../../../../model/event_dm.dart';
import '../../../../model/user_dm.dart';
import '../../../../providers/event_provider.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/categories_tab_bar.dart';
import '../../../../widgets/event_widget.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  List<EventDM> filteredEvents = [];
  var selectedCategory = AppConstants.allCategories[0];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<EventProvider>(context);

    List<EventDM> events = provider.eventsList;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          buildHeader(),
          StreamBuilder(
              stream: getEventsFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  events = snapshot.data!;
                  filterEvents(events);
                  return Expanded(
                    child: Column(
                      children: [buildCategoriesTabBar(), buildEventsList()],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })
        ],
      ),
    );
  }

  buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Text("Welcome Back ✨", style: AppTextStyles.grey14Regular),
            const Spacer(),
            const Icon(Icons.brightness_5, color: AppColors.blue, size: 24),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                "En",
                style: TextStyle(color: AppColors.white, fontSize: 14),
              ),
            ),
          ],
        ),
        Text(
          UserDM.currentUser!.name,
          textAlign: TextAlign.start,
          style: AppTextStyles.black20SemiBold,
        ),
      ],
    );
  }

  buildCategoriesTabBar() {
    return CategoriesTabBar(
      categories: AppConstants.allCategories,
      onChanged: (category) {
        selectedCategory = category;
        setState(() {});
      },
    );
  }

  void filterEvents( List<EventDM>events) {
    if (selectedCategory != AppConstants.all) {
      filteredEvents = events.where((event) {
        return event.categoryDM.name == selectedCategory.name;
      }).toList();
    } else {
      filteredEvents = events;
    }
  }

  buildEventsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredEvents.length,
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditScreen(event: filteredEvents[index])));
              },
              child: EventWidget(eventDM: filteredEvents[index]));
        },
      ),
    );
  }
}
