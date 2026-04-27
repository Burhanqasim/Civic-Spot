import 'package:civicspot/core/theme/app_colors.dart';
import 'package:civicspot/features/report/controllers/report_controllers.dart';
import 'package:civicspot/shared/widgets/custom_textfield.dart';
import 'package:civicspot/shared/widgets/primary_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/widgets/category_chip.dart';

class ReportView extends GetView<ReportControllers> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report Issue"),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
            onPressed: ()=> Get.back(),
            icon: Icon(Icons.arrow_back),),
      ),
      body:
      SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1 Category Selector
                SizedBox(
                  height: 44,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.categories.length,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      final category = controller.categories[index];
                      return Obx(() => CategoryChip(
                          label: category,
                          isSelected: controller.selectedCategory.value == category,
                          onTap: ()=> controller.setCategory(category)
                      ),
                      );
                    },
                  ),
                ),
                // 2 Title and description
                CustomTextField(
                  label: "Title",
                  hint: "e.g. Deep Pothole in the main street",
                  controller: controller.titleController,
                ),
                CustomTextField(
                  label: "Description",
                  hint: "Add more detail about the severity of issue and location",
                  controller: controller.descriptiveController,
                ),
                // 3 Image Picker Optional

                // 4 Map location Current / Map location Selector
                Obx(()=> Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.paper,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    controller.selectedLocation.value == null ?
                        "Fetching Current location" :
                        "location : ${controller.selectedLocation.value!.latitude.toStringAsFixed(5)}, ${controller.selectedLocation.value!.longitude.toStringAsFixed(5)},",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )
                ),
                // 5 Submit Button
                Obx(()=>
                    PrimaryButton(
                        text: "Submit Report",
                        isLoading: controller.isLoading.value,
                        onPressed: ()=> controller.submitReport())
                )
              ],
            ),
      ),
      ),
    );
  }
}
