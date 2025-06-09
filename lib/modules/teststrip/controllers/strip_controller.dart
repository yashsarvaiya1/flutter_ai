import 'package:api_demo/modules/teststrip/index.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';

class StripController extends GetxController {
  var obj = <Rxn<ItemModel>>[].obs;
  final StripService _service = Get.find();
  var isLoading = false.obs;
  var scolor = Rxn<Color>().obs;
  var svalue = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getStripeData();
  }

  Future<void> getStripeData() async {
    isLoading.value = true;
    obj.value = (await _service.fetchItems() ?? [])
        .map((e) => Rxn<ItemModel>(e))
        .toList();

    isLoading.value = false;
  }

  void updateSelected(int itemIndex, int valueIndex) {
    var item = obj[itemIndex].value!;
    // Update reactive fields inside the model
    item.scolor.value = item.getColor(item.values[valueIndex].color);
    item.svalue.value = item.values[valueIndex].value;

    print(item.svalue.value);
  }
}
