import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gcuf/widgets/My_Chart.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StaggeredGridView.count(
        physics: NeverScrollableScrollPhysics(),
        // scrollDirection: Axis.vertical,
        shrinkWrap: true,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        crossAxisCount: 10,
        children: <Widget>[
          MyChart(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 20,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 20,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 20,
          ),
        ],
        staggeredTiles: [
          StaggeredTile.extent(4, 250),
          StaggeredTile.extent(6, 125),
          StaggeredTile.extent(6, 125),
          StaggeredTile.extent(10, 250)
        ],
      ),
    );
  }
}
