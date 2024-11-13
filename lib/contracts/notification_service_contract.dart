import 'package:atc_mobile_app/models/event_model.dart';

abstract class NotificationServiceContract {
  ///Send message notification.
  void sendMessageNotification(String message);
  ///Schedule notification.
  void scheduleEventNotification(EventModel model, int mask);
}