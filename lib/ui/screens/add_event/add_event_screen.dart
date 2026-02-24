
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

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  CategoryDM selectedCategory = AppConstants.customCategories[0];
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Event", style: AppTextStyles.black16Medium),
          centerTitle: true,
          backgroundColor: Colors.transparent,
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
                        height: MediaQuery.of(context).size.height * .25,
                      ),
                      const SizedBox(height: 16),
                      CategoriesTabBar(
                        categories: AppConstants.customCategories,
                        onChanged: (selectedCategory) {
                          this.selectedCategory = selectedCategory;
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Title",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.black16Medium,
                      ),
                      const SizedBox(height: 8),
                      AppTextField(
                        hint: "Event Title",
                        controller: titleController,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Description",
                        textAlign: TextAlign.start,
                        style: AppTextStyles.black16Medium,
                      ),
                      const SizedBox(height: 8),
                      AppTextField(
                        hint: "Event Description....",
                        minLines: 4,
                        controller: descriptionController,
                      ),
                      const SizedBox(height: 16),
                      buildChooseDateRow(),
                      const SizedBox(height: 16),
                      buildChooseTimeRow(),
                    ],
                  ),
                ),
              ),
              buildAddEventButton(),
            ],
          ),
        ),
      ),
    );
  }

  buildChooseDateRow() => Row(
    children: [
      const Icon(Icons.calendar_month, size: 24, color: AppColors.blue),
      const SizedBox(width: 8),
      const Text("Event Date", style: AppTextStyles.black16Medium),
      Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
      const Spacer(),
      InkWell(
        onTap: () async {
          selectedDate =
              await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                initialDate: selectedDate,
              ) ??
                  selectedDate;
          setState(() {});
        },
        child: Text(
          "Choose Date",
          style: AppTextStyles.blue14Regular.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ],
  );

  buildChooseTimeRow() => Row(
    children: [
      const Icon(Icons.access_time, size: 24, color: AppColors.blue),
      const SizedBox(width: 8),
      const Text("Event Time", style: AppTextStyles.black16Medium),
      Text(" ${selectedTime.hour}:${selectedTime.minute}"),
      const Spacer(),
      InkWell(
        onTap: () async {
          selectedTime =
              await showTimePicker(
                context: context,
                initialTime: selectedTime,
              ) ??
                  selectedTime;
          setState(() {});
        },
        child: Text(
          "Choose Time",
          style: AppTextStyles.blue14Regular.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ],
  );

  buildAddEventButton() => EventlyButton(
    text: "Add Event",
    onPress: () async {
      showLoading(context);

      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );
      EventDM eventDM = EventDM(
        id: "",
        ownerId: UserDM.currentUser!.id,
        categoryDM: selectedCategory,
        dateTime: selectedDate,
        title: titleController.text,
        description: descriptionController.text,
      );
      await createEventInFirestore(eventDM);
      Provider.of<EventProvider>(context,listen: false).addEvent(eventDM);

      Navigator.pop(context); //hide loading
      Navigator.pop(context); //go back to navigation screen
    },
  );
}