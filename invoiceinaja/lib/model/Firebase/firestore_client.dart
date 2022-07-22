import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:invoiceinaja/model/recent_activities_model.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveRecent(RecentActivitiesModel recentActivitiesModel) {
    return _db
        .collection('recent_activities')
        .doc()
        .set(recentActivitiesModel.toJson());
  }

  Future<List<RecentActivitiesModel>> getRecentActivities(int id) {
    return _db
        .collection('recent_activities')
        .where('user_id', isEqualTo: id)
        .get()
        .then((value) => value.docs
            .map((data) => RecentActivitiesModel.fromJson(data.data()))
            .toList());
  }
}
