import 'package:civicspot/core/theme/app_colors.dart';
import 'package:civicspot/features/report/controllers/report_controllers.dart';
import 'package:civicspot/shared/widgets/custom_textfield.dart';
import 'package:civicspot/shared/widgets/primary_button.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
                Text(
                  "Photo Evidence (Optional)",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: .w600,
                  ),
                ),

                SizedBox(height: 16,),
                Obx(()=>
                    GestureDetector(
                      onTap: ()=> _showImageSourceDialogue(context),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          color: AppColors.paper,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(color: AppColors.secondary.withValues(alpha: 0.3), width: 1),
                        ),
                        child: controller.selectedImage.value != null
                            ?  ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(11),
                              child: Image.file(
                                controller.selectedImage.value!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                            : Column(
                          mainAxisAlignment: .center,
                          children: [
                            Icon(Icons.add_a_photo_outlined,
                              color: AppColors.primary,
                            ),
                            SizedBox(height: 8,),
                            Text("Tap to add an Image",
                            style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                ),
                SizedBox(height: 24),
                // 4 Map location Current / Map location Selector
                Obx(()=> Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.paper,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          controller.selectedLocation.value == null ?
                              "Fetching Current location" :
                              "location : ${controller.selectedLocation.value!.latitude.toStringAsFixed(5)}, ${controller.selectedLocation.value!.longitude.toStringAsFixed(5)},",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      TextButton(
                          onPressed: ()=> controller.openLocationPicker(), // Location Picker View
                          child: Text("Edit on Camera"),
                      ),
                    ],
                  ),
                )
                ),
                // 5 Submit Button
                Obx(()=>
                    PrimaryButton(
                        text: "Submit Report",
                        isLoading: controller.isLoading.value,
                        onPressed: ()=> controller.submitReport())

                ),
            ]
            ),
      ),
      ),
    );
  }
  // Bottom Sheet
  _showImageSourceDialogue(BuildContext context){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Take a Photo"),
              onTap: (){
                Get.back();
                controller.pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Choose Photo from Gallery"),
              onTap: (){
                Get.back();
                controller.pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),

      ),
    );
  }
}
