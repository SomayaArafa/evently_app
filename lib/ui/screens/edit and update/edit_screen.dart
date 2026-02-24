import 'package:evenlyproject/ui/screens/edit%20and%20update/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../firebase_utils/firestore_utility.dart';
import '../../model/event_dm.dart';
import '../../model/user_dm.dart';
import '../../providers/event_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_dialogs.dart';
import '../../utils/app_styles.dart';
import '../../utils/constants.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/categories_tab_bar.dart';
import '../../widgets/evently_button.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key, required this.event});

  final EventDM event;

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  CategoryDM selectedCategory = AppConstants.customCategories[0];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final event = widget.event;
    selectedCategory = event.categoryDM;
    selectedDate = event.dateTime;
    selectedTime = TimeOfDay(
      hour: event.dateTime.hour,
      minute: event.dateTime.minute,
    );
    titleController.text = event.title;
    descriptionController.text = event.description;
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
    String formattedTime =
        "${selectedTime.hourOfPeriod.toString().padLeft(2, '0')}:"
        "${selectedTime.minute.toString().padLeft(2, '0')} "
        "${selectedTime.period == DayPeriod.am ? "AM" : "PM"}";
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Event Details",
            style: AppTextStyles.black20SemiBold,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: [
            InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              UpdateScreen(event: widget.event)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          color: AppColors.white),
                      child: const Icon(Icons.edit, color: AppColors.blue)),
                )),
            InkWell(
                onTap: () async{
                  try {
                    selectedDate = DateTime(
                      selectedDate.year,
                      selectedDate.month,
                      selectedDate.day,
                      selectedTime.hour,
                      selectedTime.minute,
                    );

                    EventDM eventDM = EventDM(
                      id: widget.event.id,
                      ownerId: UserDM.currentUser!.id,
                      categoryDM: selectedCategory,
                      dateTime: selectedDate,
                      title: titleController.text,
                      description: descriptionController.text,
                    );

                    await deleteEventFromFirestore(eventDM);
                    Provider.of<EventProvider>(context, listen: false)
                        .deleteEvent(eventDM.id);
                    Navigator.pop(context);
                  } catch (e) {
                    print('el erro elly hasal ${e.toString()}');
                    showMessage(
                        context, "Failed to update event ${e.toString()}",
                        title: "Error", posText: "Ok");
                  }
                },
                child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        color: AppColors.white),
                    child: const Icon(Icons.delete, color: AppColors.red))),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Image.asset(
                        selectedCategory.imagePath,
                        height: MediaQuery.of(context).size.height * .30,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        titleController.text,
                        textAlign: TextAlign.start,
                        style:
                            AppTextStyles.black16Medium.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 70,
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    color: AppColors.offWhite,
                                    borderRadius: BorderRadius.circular(8)),
                                child: const Icon(Icons.calendar_month,
                                    size: 24, color: AppColors.blue),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  formattedDate,
                                  style: AppTextStyles.black16Medium,
                                ),
                                Text(
                                  textAlign: TextAlign.start,
                                  formattedTime,
                                  style: AppTextStyles.grey14Regular,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "Description",
                        textAlign: TextAlign.start,
                        style:
                            AppTextStyles.black16Medium.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            descriptionController.text,
                            style: AppTextStyles.black14Medium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
