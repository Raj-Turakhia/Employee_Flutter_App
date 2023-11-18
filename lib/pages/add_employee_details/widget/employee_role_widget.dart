import 'package:employee_app/constants/constants.dart';
import 'package:employee_app/constants/theme.dart';
import 'package:employee_app/core/context_extension.dart';
import 'package:employee_app/pages/add_employee_details/employee_roles/employee_role_bottomsheet.dart';
import 'package:employee_app/widget/common_icon.dart';
import 'package:employee_app/widget/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeRoleWidget extends StatefulWidget {
  final String text;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onTap;
  final Color? color;
  final Function(String) onRoleSelected;
  const EmployeeRoleWidget(
      {super.key,
      this.prefixIcon,
      this.onTap,
      this.color = Colors.white,
      required this.text,
      this.suffixIcon,
      required this.onRoleSelected});

  @override
  State<EmployeeRoleWidget> createState() => _EmployeeRoleWidgetState();
}

class _EmployeeRoleWidgetState extends State<EmployeeRoleWidget> {
  final List<String> roleList = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owener'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: ThemeConstants.borderColor),
          borderRadius: BorderRadius.circular(4.r)),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        onTap: () {
          context.dismissKeyboard();
          _showEmployeeRoleBottomsheet();
        },
        leading: Padding(
          padding: EdgeInsets.only(left: context.getWidthByPercentage(2.45)),
          child: const CommonIconWidget(
            icon: AppConstants.IC_ROLE,
          ),
        ),
        title: CommonText(
          text: widget.text,
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          fontColor: widget.color ?? ThemeConstants.textColor,
        ),
        trailing: Padding(
          padding: EdgeInsets.only(right: context.getWidthByPercentage(2.45)),
          child: GestureDetector(
            onTap: widget.onTap,
            child: CommonIconWidget(
              icon: AppConstants.IC_DROP_DOWN,
              imageHeight: context.getHeightByPercentage(2.51),
              imageWidth: context.getWidthByPercentage(4.90),
            ),
          ),
        ),
      ),
    );
  }

  void _showEmployeeRoleBottomsheet() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      context: context,
      builder: (buildContext) {
        return EmployeeRoleBottomSheet(
          onRoleSelected: widget.onRoleSelected,
          roleList: roleList,
        );
      },
    );
  }
}
