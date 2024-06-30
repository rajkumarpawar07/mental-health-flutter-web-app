import 'package:ai_chatbot/services/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  RxInt currentMoodRating = 3.obs;

  void addMoodRating(int rating) async {
    try {
      rating = currentMoodRating.value;
      final userId = AuthenticationRepository.instance.authUser!.uid;

      final userEmotionsRef = FirebaseFirestore.instance
          .collection('UserEmotions')
          .where('UserId', isEqualTo: userId);

      final querySnapshot = await userEmotionsRef.get();

      if (querySnapshot.docs.isNotEmpty) {
        final docId = querySnapshot.docs.first.id;
        final emotions =
            querySnapshot.docs.first.get('Emotions') as Map<String, dynamic>;

        if (emotions.containsKey(rating.toString())) {
          emotions[rating.toString()] = (emotions[rating.toString()] ?? 0) + 1;
        } else {
          emotions[rating.toString()] = 1;
        }

        await FirebaseFirestore.instance
            .collection('UserEmotions')
            .doc(docId)
            .update({
          'Emotions': emotions,
        });
        currentMoodRating.value = 3;
      } else {
        await FirebaseFirestore.instance.collection('UserEmotions').add({
          'UserId': userId,
          'Emotions': {rating.toString(): 1},
        });
        currentMoodRating.value = 3;
      }
    } catch (e) {
      print('Error: $e');
      currentMoodRating.value = 3;
    }
  }
}
