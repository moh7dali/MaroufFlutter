import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Marouf/view/widgets/actions_app_bar_widget.dart';
import 'package:Marouf/view/widgets/product_grid_view_widget.dart';

import '../../utils/theme/app_theme.dart';

class ProductMenuScreen extends StatelessWidget {
  const ProductMenuScreen({Key? key, required this.categoryId, required this.categoryName}) : super(key: key);
final int categoryId;
final String categoryName;
// todo work here app bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ActionsAppBarWidget(
            isHome: true,
          )
        ],
        iconTheme: const IconThemeData(color: AppTheme.colorPrimaryDark),
        title: Text(categoryName,
            style: AppTheme.boldStyle(
                color: AppTheme.colorPrimaryDark, size: 16.sp)),
      ),
      body: ProductGridViewWidget(categoryId: categoryId,categoryTag: categoryName)//pass id to send request api
    );
  }
}
