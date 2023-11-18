import 'package:employee_app/bloc/employee_bloc.dart';
import 'package:employee_app/constants/constants.dart';
import 'package:employee_app/constants/string_constants.dart';
import 'package:employee_app/constants/theme.dart';
import 'package:employee_app/core/context_extension.dart';
import 'package:employee_app/pages/add_employee_details/widget/common_date_pick_widget.dart';
import 'package:employee_app/pages/add_employee_details/widget/employee_role_widget.dart';
import 'package:employee_app/services/database/models/employee.dart';
import 'package:employee_app/utils/date_helper.dart';
import 'package:employee_app/widget/common_button.dart';
import 'package:employee_app/widget/common_date_picker_popup.dart';
import 'package:employee_app/widget/common_icon.dart';
import 'package:employee_app/widget/common_text.dart';
import 'package:employee_app/widget/custom_textField.dart';
import 'package:employee_app/widget/percentage_sizebox.dart';
import 'package:employee_app/widget/simple_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

class AddEmployeeDetailsScreen extends StatefulWidget {
  const AddEmployeeDetailsScreen({super.key});

  @override
  State<AddEmployeeDetailsScreen> createState() =>
      _AddEmployeeDetailsScreenState();
}

class _AddEmployeeDetailsScreenState extends State<AddEmployeeDetailsScreen> {
  final nameController = TextEditingController();
  final selectRole = ValueNotifier<String>('');
  DateTime fromDate = DateTime.now();
  DateTime? toDate;
  Employee? _employee;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (mounted) {
          _employee = ModalRoute.of(context)?.settings.arguments as Employee?;
          if (_employee != null) {
            setState(() {
              nameController.text = _employee?.name ?? "";
              selectRole.value = _employee?.role ?? "";
              fromDate = DateHelper.dateDisplayFormat
                  .parse(_employee?.startDate ?? "");
              toDate = _employee?.endDate != null &&
                      _employee!.endDate!.isNotEmpty
                  ? DateHelper.dateDisplayFormat.parse(_employee?.endDate ?? "")
                  : null;
            });
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        titleText: _employee != null
            ? StringConstants.editEmployeeTitle
            : StringConstants.addEmployeeTitle,
        isLeading: true,
        actions: [
          if (_employee != null)
            InkWell(
              onTap: () {
                context
                    .read<EmployeeBloc>()
                    .add(DeleteEmployeeDetailEvent(employee: _employee!));
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(
                  right: context.getWidthByPercentage(4.41),
                ),
                child: const CommonIconWidget(icon: AppConstants.IC_DELETE),
              ),
            )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.getWidthByPercentage(3.92)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const PercentageSizeBox(
            heightInPer: 3.01,
          ),
          CustomTextField(
            prefixIcon: AppConstants.IC_PERSON,
            controller: nameController,
            hintText: StringConstants.employeeName,
          ),
          const PercentageSizeBox(
            heightInPer: 2.88,
          ),
          ValueListenableBuilder<String>(
            valueListenable: selectRole,
            builder: (context, value, child) {
              return EmployeeRoleWidget(
                text: selectRole.value.isEmpty
                    ? StringConstants.selectRole
                    : selectRole.value,
                color: selectRole.value.isNotEmpty
                    ? ThemeConstants.bottomSheetTextColor
                    : ThemeConstants.textColor,
                onRoleSelected: (String role) {
                  selectRole.value = role;
                },
              );
            },
          ),
          const PercentageSizeBox(
            heightInPer: 2.88,
          ),
          Row(
            children: [
              Flexible(
                child: CommonDatePickWidget(
                  text: isSameDay(fromDate, DateTime.now())
                      ? StringConstants.today
                      : DateHelper.displayDate(fromDate),
                  prefixIcon: AppConstants.IC_CALENDAR,
                  fontColor: ThemeConstants.bottomSheetTextColor,
                  onTap: () async {
                    final selectedDateTime = await showDialog(
                      context: context,
                      builder: (context) {
                        return CommonDatePickerDialog(
                            selectedDay: fromDate,
                            dateButtonList: AppConstants.fromDateButtonList);
                      },
                    );
                    setState(() {
                      fromDate = selectedDateTime;
                      toDate = null;
                    });
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: context.getWidthByPercentage(3.8)),
                child: const CommonIconWidget(icon: AppConstants.IC_FORWARD),
              ),
              Flexible(
                child: CommonDatePickWidget(
                  text: toDate != null
                      ? DateHelper.displayDate(toDate!)
                      : StringConstants.noDate,
                  fontColor: toDate != null
                      ? ThemeConstants.bottomSheetTextColor
                      : null,
                  prefixIcon: AppConstants.IC_CALENDAR,
                  onTap: () async {
                    final selectedDateTime = await showDialog(
                      context: context,
                      builder: (context) {
                        return CommonDatePickerDialog(
                          dateButtonList: AppConstants.toDateButtonList,
                          firstDay: fromDate,
                        );
                      },
                    );
                    if (selectedDateTime != null) {
                      setState(() {
                        toDate = selectedDateTime;
                      });
                    }
                  },
                ),
              ),
            ],
          )
        ]),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: ThemeConstants.dividerColor, width: 2),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            right: context.getWidthByPercentage(3.92),
            bottom: context.getHeightByPercentage(1.5),
            top: context.getHeightByPercentage(1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CommonButton(
                buttonText: StringConstants.cancel,
                buttonColor: ThemeConstants.buttonColor,
                onPressed: () {
                  context.dismissKeyboard();
                  Navigator.of(context).pop();
                },
                buttonTextColor: ThemeConstants.primaryColor,
              ),
              const PercentageSizeBox(
                widthInPer: 3.92,
              ),
              CommonButton(
                buttonText: StringConstants.save,
                onPressed: () {
                  context.dismissKeyboard();
                  if (nameController.text.isEmpty) {
                    getCommonError(StringConstants.nameError);
                  } else if (selectRole.value.isEmpty) {
                    getCommonError(StringConstants.roleError);
                  } else {
                    if (_employee != null) {
                      context.read<EmployeeBloc>().add(
                            UpdateEmployeeDetailEvent(
                              employee: Employee(
                                id: _employee?.id,
                                name: nameController.text,
                                role: selectRole.value,
                                startDate: DateHelper.displayDate(fromDate),
                                endDate: toDate != null
                                    ? DateHelper.displayDate(toDate!)
                                    : null,
                              ),
                            ),
                          );
                    } else {
                      context.read<EmployeeBloc>().add(
                            AddEmployeeDetailEvent(
                              employee: Employee(
                                name: nameController.text,
                                role: selectRole.value,
                                startDate: DateHelper.displayDate(fromDate),
                                endDate: toDate != null
                                    ? DateHelper.displayDate(toDate!)
                                    : null,
                              ),
                            ),
                          );
                    }
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  getCommonError(String error) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CommonText(
          text: error,
          fontColor: Colors.white,
        ),
      ),
    );
  }
}
