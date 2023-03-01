import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/category_model.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class CategoryRepository {
  CollectionReference<CategoryModel> categoryRef =
      FirebaseService.db.collection("categories").withConverter<CategoryModel>(
            fromFirestore: (snapshot, _) {
              return CategoryModel.fromFirebaseSnapshot(snapshot);
            },
            toFirestore: (model, _) => model.toJson(),
          );
  Future<List<QueryDocumentSnapshot<CategoryModel>>> getCategories() async {
    try {
      var data = await categoryRef.get();
      bool hasData = data.docs.isNotEmpty;
      if (!hasData) {
        makeCategory().forEach((element) async {
          await categoryRef.add(element);
        });
      }
      final response = await categoryRef.get();
      var category = response.docs;
      return category;
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<DocumentSnapshot<CategoryModel>> getCategory(String categoryId) async {
    try {
      print(categoryId);
      final response = await categoryRef.doc(categoryId).get();
      return response;
    } catch (e) {
      rethrow;
    }
  }

  List<CategoryModel> makeCategory() {
    return [
      CategoryModel(
          categoryName: "Bread",
          status: "active",
          imageUrl:
              "https://imgs.search.brave.com/hvm3g3AbImU-QE_ocrIrr0Hk1Q8ThRPIUQ2-f2B0Vuw/rs:fit:1030:225:1/g:ce/aHR0cHM6Ly90c2Ux/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5t/dV81dUpQNzZQWnVp/SjlpeEFJcUhRSGFE/YSZwaWQ9QXBp"),
      CategoryModel(
          categoryName: "Diary product",
          status: "active",
          imageUrl:
              "https://imgs.search.brave.com/QNe8mJ-hm7W28QMqoetccnx8T7rfh-_rz5lcDfEWBo8/rs:fit:636:225:1/g:ce/aHR0cHM6Ly90c2U0/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5s/UlZUc1otcmtScnZt/R0dValU4MlNnSGFG/aCZwaWQ9QXBp"),
      CategoryModel(
          categoryName: "Vegitable",
          status: "active",
          imageUrl:
              "https://imgs.search.brave.com/pS-xqDBxP7ThTkDPV0bU3ZpFHtS_fydp22p73RjFHKA/rs:fit:693:225:1/g:ce/aHR0cHM6Ly90c2Ux/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5M/VEMtZXlTcHV4Tmpj/TzFuTFlFZ013SGFG/RSZwaWQ9QXBp"),
      CategoryModel(
          categoryName: "Meat product",
          status: "active",
          imageUrl:
              "https://imgs.search.brave.com/4qj8eJBlbC6UZ7LAQZZpGATxQKetdkpEBWAsuA07Dko/rs:fit:655:225:1/g:ce/aHR0cHM6Ly90c2Uz/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5u/WjJIanFDbXhJTzVU/ZG9VZ3RuUXBnSGFG/WCZwaWQ9QXBp"),
      CategoryModel(
          categoryName: "Liquid product",
          status: "active",
          imageUrl:
              "https://imgs.search.brave.com/tI5YqsYP5wdaRZCl4yf731_L09mcrGr3X8I05VV1ukA/rs:fit:632:225:1/g:ce/aHR0cHM6Ly90c2U0/Lm1tLmJpbmcubmV0/L3RoP2lkPU9JUC5q/Yk42SW5jZFhpUmtt/bXN2QVhmaEd3SGFG/aiZwaWQ9QXBp"),
    ];
  }
}
