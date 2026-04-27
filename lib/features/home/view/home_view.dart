import 'package:civicspot/core/theme/app_colors.dart';
import 'package:civicspot/features/home/controllers/home_controllers.dart';
import 'package:civicspot/shared/widgets/category_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeView extends GetView<HomeControllers> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Placeholder for Google Map
          GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(25.364488, 68.316214), zoom: 14),
          onMapCreated: controller.onMapCreated,
            myLocationButtonEnabled: true,
          ),
          // Top Layer
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 16,
                  bottom: 16,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    AppColors.background,
                    AppColors.background.withValues(alpha: 0.8),
                    AppColors.background.withValues(alpha: 0.0),
                  ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  ),
                ),
                child: Column(
                  mainAxisSize: .min,
                  children: [
                    // Mock Search field
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.paper,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 8),
                            Builder(
                              builder: (context) {
                                return IconButton(
                                  icon: const Icon(
                                    Icons.menu_rounded,
                                    color: AppColors.textMain,
                                  ),
                                  onPressed: () {
                                    Scaffold.of(context).openDrawer();
                                  },
                                );
                              },
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'Search neighborhoods...',
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.textSecondary),
                              ),
                            ),
                            const VerticalDivider(
                              indent: 10,
                              endIndent: 10,
                              color: Colors.grey,
                            ),
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.secondary.withValues(
                                alpha: 0.2,
                              ),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: const Icon(
                                  Icons.my_location_rounded,
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                                onPressed: () {
                                  final pos = controller.initialPosition.value;
                                  controller.mapController?.animateCamera(
                                    CameraUpdate.newLatLng(pos),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // filter bar
                    // Categoy chips
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                          itemCount: controller.categories.length,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          itemBuilder: (context, index) {
                            final category = controller.categories[index];
                            return Obx(() => CategoryChip(
                                label: category,
                                isSelected: controller.selectedCategory.value == category,
                                onTap: ()=> controller.selectCategory(category)
                            ),
                            );
                          },
                      ),
                    ),
                    
                  ],
                ),
              ),
          ),
          // Floating buttons for reporting issues
          Positioned(
            bottom: 24,
            right: 24,
            left: 24,
            child:
          ElevatedButton(
              onPressed: (){},
              child: Text("Report Issue"),
          ),
          ),
        ],
      ),
    );
  }
}

// Api Key for Android and IOS
// AIzaSyBj9kqKc0VBw2tq9vfhW89BsaYKajKj4qA
