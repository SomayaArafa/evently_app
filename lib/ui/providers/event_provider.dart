import 'package:flutter/material.dart';

import '../model/event_dm.dart';

class EventProvider extends ChangeNotifier {

  List<EventDM> eventsList = [];

  void addEvent(EventDM event){
    eventsList.add(event);
    notifyListeners();
  }

  void updateEvent(EventDM updatedEvent) {
    final index = eventsList.indexWhere((e) => e.id == updatedEvent.id);
    if (index != -1) {
      eventsList[index] = updatedEvent;
      notifyListeners();
    }
  }

  void deleteEvent(String eventId) {
    eventsList.removeWhere((e) => e.id == eventId);
    notifyListeners();
  }

}