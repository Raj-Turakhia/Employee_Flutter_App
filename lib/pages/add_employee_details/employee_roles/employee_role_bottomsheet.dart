import 'package:employee_app/constants/theme.dart';
import 'package:employee_app/widget/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmployeeRoleBottomSheet extends StatelessWidget {
  const EmployeeRoleBottomSheet(
      {Key? key, required this.onRoleSelected, required this.roleList})
      : super(key: key);
  final Function(String) onRoleSelected;
  final List<String> roleList;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: roleList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) {
        return const Divider(
          color: ThemeConstants.borderColor,
          height: 1,
        );
      },
      itemBuilder: (context, index) {
        return ListTile(contentPadding: EdgeInsets.zero,
          dense: true,
          onTap: () {
            onRoleSelected(roleList[index]);
            Navigator.pop(context);
          },
          title: Center(
            child: CommonText(
              text: roleList[index],
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              fontColor: ThemeConstants.bottomSheetTextColor,
            ),
          ),
        );
      },
    );
  }
}
