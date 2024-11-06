import 'package:atc_mobile_app/models/event_model.dart';

abstract class NotificationServiceContract {
  void sendMessageNotification(String message);
  void scheduleEventNotification(EventModel model, int mask);
}