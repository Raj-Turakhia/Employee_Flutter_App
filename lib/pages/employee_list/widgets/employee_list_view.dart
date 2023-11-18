import 'package:employee_app/bloc/employee_bloc.dart';
import 'package:employee_app/constants/constants.dart';
import 'package:employee_app/constants/string_constants.dart';
import 'package:employee_app/constants/theme.dart';
import 'package:employee_app/core/context_extension.dart';
import 'package:employee_app/services/database/models/employee.dart';
import 'package:employee_app/utils/date_helper.dart';
import 'package:employee_app/widget/common_icon.dart';
import 'package:employee_app/widget/common_text.dart';
import 'package:employee_app/widget/percentage_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sticky_headers/sticky_headers.dart';

class EmployeeListView extends StatefulWidget {
  final String headerTitle;
  final List<Employee> employeeList;
  final ValueChanged<Employee> onTap;

  const EmployeeListView({
    super.key,
    required this.employeeList,
    required this.headerTitle,
    required this.onTap,
  });

  @override
  State<EmployeeListView> createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {
  @override
  Widget build(BuildContext context) {
    return StickyHeader(
      header: employeeHeader(text: widget.headerTitle),
      content: ListView.separated(
        itemCount: widget.employeeList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) {
          return const Divider(
            color: ThemeConstants.dividerColor,
            height: 1,
          );
        },
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            background: buildSwipeToDeleteBackground(),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              final removedEmployee = widget.employeeList.removeAt(index);
              context
                  .read<EmployeeBloc>()
                  .add(DeleteEmployeeDetailEvent(employee: removedEmployee));
              showSnackBar(index, removedEmployee);
            },
            child: InkWell(
              onTap: () {
                widget.onTap(widget.employeeList[index]);
              },
              child: AnimatedContainer(
                width: double.infinity,
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(
                  horizontal: context.getWidthByPercentage(3.92),
                  vertical: context.getHeightByPercentage(1.72),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      maxLines: 2,
                      text: widget.employeeList[index].name ?? "",
                      fontColor: ThemeConstants.bottomSheetTextColor,
                    ),
                    const PercentageSizeBox(
                      heightInPer: 0.75,
                    ),
                    CommonText(
                      text: widget.employeeList[index].role ?? "",
                      fontColor: ThemeConstants.textColor,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                      fontSize: 14.sp,
                    ),
                    const PercentageSizeBox(
                      heightInPer: 0.75,
                    ),
                    CommonText(
                      text: widget.employeeList[index].endDate != null &&
                              widget.employeeList[index].endDate!.isNotEmpty
                          ? '${DateHelper.displayHomeDate(widget.employeeList[index].startDate!)} - ${DateHelper.displayHomeDate(widget.employeeList[index].endDate!)}'
                          : '${StringConstants.from} ${DateHelper.displayHomeDate(widget.employeeList[index].startDate!)}',
                      fontColor: ThemeConstants.textColor,
                      fontWeight: FontWeight.w400,
                      maxLines: 2,
                      fontSize: 14.sp,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  employeeHeader(
      {required String text, Color? fontColor, FontWeight? fontWeight}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
          top: context.getHeightByPercentage(2.01),
          bottom: context.getHeightByPercentage(2.01),
          left: context.getWidthByPercentage(3.92)),
      color: ThemeConstants.dividerColor,
      child: CommonText(
        text: text,
        fontColor: fontColor,
        fontWeight: fontWeight,
      ),
    );
  }

  Widget buildSwipeToDeleteBackground() {
    return Container(
      color: Colors.red,
      padding: EdgeInsets.only(right: context.getWidthByPercentage(3.92)),
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: const CommonIconWidget(
          icon: AppConstants.IC_DELETE,
        ),
        onPressed: () {},
      ),
    );
  }

  showSnackBar(int index, Employee removedEmployee) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const CommonText(
          text: StringConstants.employeeDataDeleted,
          fontColor: Colors.white,
        ),
        action: SnackBarAction(
          label: StringConstants.undo,
          textColor: ThemeConstants.primaryColor,
          onPressed: () {
            // setState(() {
            //   listPastEmployee.insert(index, removedEmployee);
            // });
          },
        ),
      ),
    );
  }
}
