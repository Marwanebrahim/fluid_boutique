import 'package:fluid_boutique/core/configs/app_colors.dart';
import 'package:fluid_boutique/core/configs/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpecsGrid extends StatelessWidget {
  const SpecsGrid({super.key, required this.productCategory});
  final String productCategory;

  @override
  Widget build(BuildContext context) {
    final specs = [
      {'icon': Icons.check_circle_outline, 'text': productCategory},
      {'icon': Icons.local_shipping_outlined, 'text': 'Fast Delivery'},
      {'icon': Icons.workspace_premium_outlined, 'text': 'Premium Quality'},
      {'icon': Icons.eco_outlined, 'text': 'Sustainability Grade A'},
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 6.h,
      ),
      itemCount: specs.length,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Icon(
              specs[index]['icon'] as IconData,
              size: 14.w,
              color: AppColors.textTertiary,
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                specs[index]['text'] as String,
                style: AppTextStyles.regular(
                  size: 12,
                  color: AppColors.textSecondary,
                  font: AppFont.inter,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        );
      },
    );
  }
}
