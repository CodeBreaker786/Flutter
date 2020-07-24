import 'package:avalinks/models/service/category/ServiceCategory.dart';
import 'package:flutter/material.dart';

class ServiceCategoryItemView extends StatelessWidget {
  ServiceCategoryItemView(this.entry, {this.onItemSelected = null});

  ServiceCategory entry;
  Function(ServiceCategory) onItemSelected;

  Widget _buildTiles(ServiceCategory root) {
    if (root.children.isEmpty)
      return ListTile(
        title: Text(
          root.serviceCategoryName,
          style: TextStyle(
              fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        onTap: () {
          if (onItemSelected != null) {
            onItemSelected(root);
          }
        },
      );
    return ExpansionTile(
      key: PageStorageKey<ServiceCategory>(root),
      title: Text(
        root.serviceCategoryName,
        style: TextStyle(
            fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold),
      ),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
