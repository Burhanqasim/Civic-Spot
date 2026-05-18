import 'package:civicspot/core/theme/app_colors.dart';
import 'package:civicspot/features/issue_detail/controllers/issue_detail_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class IssueDetailView extends GetView<IssueDetailControllers> {
  const IssueDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final issue = controller.issue;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        title: Text("Issue Detail"),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image // ui
            if (issue.imageUrl != null)
              SizedBox(
                height: 220,
                child: Image.network(issue.imageUrl!, fit: .cover),
              )
            else
              Container(
                height: 220,
                color: AppColors.paper,
                child: Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 56,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            // title
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    issue.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    issue.category,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Text(
                    issue.description,
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Coordinates",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Latitude: ${issue.latitude}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Longitude: ${issue.longitude}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  // small map
                  SizedBox(
                    height: 180,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(issue.latitude, issue.longitude),
                        zoom: 15,
                      ),
                      markers: {
                        Marker(markerId: MarkerId(issue.id),
                          position: LatLng(issue.latitude, issue.longitude),
                        ),
                      },
                      zoomControlsEnabled: false,
                      myLocationEnabled: false,
                    ),
                  ),
                ],
              ),
            ),
            // co ordinates

          ],
        ),
      ),
    );
  }
}
