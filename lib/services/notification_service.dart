import 'package:mixtape/services/abstract_service.dart';
import 'package:oauth2_client/oauth2_helper.dart';

import '../models/notification.dart';
import '../models/profile.dart';

class NotificationService extends AbstractService {

  NotificationService(OAuth2Helper helper, String baseUrl) : super(helper, baseUrl);

  Future<List<Notif>> getNotifications() async {
    return getMany("/api/v1/profile/me/notification", Notif.fromJson);
  }
}