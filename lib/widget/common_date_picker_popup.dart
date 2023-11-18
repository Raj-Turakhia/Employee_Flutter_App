import 'package:employee_app/constants/constants.dart';
import 'package:employee_app/constants/string_constants.dart';
import 'package:employee_app/constants/theme.dart';
import 'package:employee_app/core/context_extension.dart';
import 'package:employee_app/utils/date_helper.dart';
import 'package:employee_app/widget/common_button.dart';
import 'package:employee_app/widget/common_icon.dart';
import 'package:employee_app/widget/date_button_model.dart';
import 'package:employee_app/widget/percentage_sizebox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class CommonDatePickerDialog extends StatefulWidget {
  const CommonDatePickerDialog(
      {Key? key, required this.dateButtonList, this.firstDay, this.selectedDay})
      : super(key: key);

  final List<DateButtonModel> dateButtonList;
  final DateTime? firstDay;
  final DateTime? selectedDay;

  @override
  State<CommonDatePickerDialog> createState() => _CommonDatePickerDialogState();
}

class _CommonDatePickerDialogState extends State<CommonDatePickerDialog> {
  late DateTime _focusedDay;
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = widget.selectedDay;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(context.getWidthByPercentage(3.92)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      // elevation: 8,
      child: Container(
        padding: EdgeInsets.only(
          left: context.getWidthByPercentage(1.00),
          right: context.getWidthByPercentage(1.00),
          top: context.getHeightByPercentage(2.00),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (1 / .25),
                crossAxisCount: 2,
                // Number of columns in the grid
                crossAxisSpacing: 8.0,
                // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
              ),
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: widget.dateButtonList.length,
              itemBuilder: (BuildContext context, int index) {
                return CommonButton(
                  buttonText: widget.dateButtonList[index].title,
                  buttonColor: widget.dateButtonList[index].isSelected
                      ? ThemeConstants.primaryColor
                      : ThemeConstants.buttonColor,
                  onPressed: () {
                    var dateTime =
                        handleDateButtonClick(widget.dateButtonList[index].id);
                    if (dateTime != null ||
                        widget.dateButtonList[index].id ==
                            AppConstants.NO_DATE_INDEX) {
                      for (var item in widget.dateButtonList) {
                        item.isSelected =
                            (item == widget.dateButtonList[index]);
                      }
                      setState(() {
                        if (widget.dateButtonList[index].id !=
                            AppConstants.NO_DATE_INDEX) {
                          _focusedDay = dateTime!;
                          _selectedDay = _focusedDay;
                        } else {
                          _selectedDay = null;
                        }
                      });
                    }
                  },
                  buttonTextColor: widget.dateButtonList[index].isSelected
                      ? Colors.white
                      : ThemeConstants.primaryColor,
                );
              },
            ),
            const PercentageSizeBox(
              heightInPer: 1.0,
            ),
            SizedBox(
              height: context.getHeightByPercentage(35.08),
              width: context.getWidthByPercentage(89.09),
              child: TableCalendar(
                rowHeight: 32,
                daysOfWeekHeight: 32,
                availableCalendarFormats: const {
                  CalendarFormat.month: '',
                },
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                ),
                headerStyle: const HeaderStyle(
                    leftChevronVisible: false, rightChevronVisible: false),
                calendarBuilders: CalendarBuilders(
                  headerTitleBuilder: (context, day) {
                    return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {
                                if (widget.firstDay != null &&
                                    DateHelper.isSameYearAndMonth(
                                            widget.firstDay!,
                                            DateTime(
                                              _focusedDay.year,
                                              _focusedDay.month,
                                            )) ==
                                        false) {
                                  setState(() {
                                    _focusedDay = DateTime(
                                      _focusedDay.year,
                                      _focusedDay.month - 1,
                                    );
                                  });
                                }
                              },
                              child: Opacity(
                                  opacity: (widget.firstDay != null &&
                                          day.isBefore(widget.firstDay!) ==
                                              true)
                                      ? 0.5
                                      : 1,
                                  child: const CommonIconWidget(
                                      icon: AppConstants.IC_CALENDAR_LEFT))),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.getWidthByPercentage(1.96)),
                            child: Text(
                              DateHelper.displayMonth(day),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                  color: ThemeConstants.bottomSheetTextColor),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                setState(() {
                                  _focusedDay = DateTime(
                                    _focusedDay.year,
                                    _focusedDay.month + 1,
                                  );
                                });
                              },
                              child: const CommonIconWidget(
                                  icon: AppConstants.IC_CALENDAR_RIGHT)),
                        ],
                      ),
                    );
                  },
                  defaultBuilder: (context, date, focusedDay) {
                    return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: context.getWidthByPercentage(0.98),
                            vertical: context.getHeightByPercentage(0.5)),
                        alignment: Alignment.center,
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                              color: ThemeConstants.bottomSheetTextColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        ));
                  },
                  todayBuilder: (context, date, focusedDay) {
                    return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: context.getWidthByPercentage(0.98),
                            vertical: context.getHeightByPercentage(0.5)),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.fromBorderSide(BorderSide(
                                color: ThemeConstants.primaryColor, width: 1))),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                              color: ThemeConstants.primaryColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        ));
                  },
                  prioritizedBuilder: (context, date, focusedDay) {
                    final showHighlight = _selectedDay != null
                        ? isSameDay(_selectedDay!, date)
                        : false;
                    return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: context.getWidthByPercentage(0.98),
                            vertical: context.getHeightByPercentage(0.5)),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: showHighlight == true
                                ? ThemeConstants.primaryColor
                                : Colors.transparent,
                            border: Border.fromBorderSide(BorderSide(
                                color: isSameDay(DateTime.now(), date)
                                    ? ThemeConstants.primaryColor
                                    : Colors.transparent,
                                width: 1))),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                              color: showHighlight == true
                                  ? Colors.white
                                  : isSameDay(DateTime.now(), date)
                                      ? ThemeConstants.primaryColor
                                      : (widget.firstDay != null &&
                                              date.isAfter(widget.firstDay!) ==
                                                  false)
                                          ? Colors.grey
                                          : ThemeConstants.bottomSheetTextColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400),
                        ));
                  },
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: ThemeConstants.bottomSheetTextColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400),
                    weekendStyle: TextStyle(
                        color: ThemeConstants.bottomSheetTextColor,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w400)),
                onDaySelected: (selectedDay, focusedDay) {
                  if (widget.firstDay == null ||
                      (widget.firstDay != null &&
                          selectedDay.isAfter(widget.firstDay!))) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay =
                          selectedDay; // You can use focusedDay to control the displayed month
                    });
                  }
                },
                focusedDay: _focusedDay,
                firstDay: DateTime(2010, 10, 16),
                lastDay: DateTime(2035, 10, 16),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: ThemeConstants.dividerColor, width: 2))),
              child: Padding(
                padding: EdgeInsets.only(
                  left: context.getWidthByPercentage(3.92),
                  right: context.getWidthByPercentage(3.92),
                  top: context.getHeightByPercentage(2.00),
                  bottom: context.getHeightByPercentage(2.08),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CommonIconWidget(
                          icon: AppConstants.IC_CALENDAR,
                        ),
                        const PercentageSizeBox(
                          widthInPer: 2.37,
                        ),
                        Text(
                          _selectedDay != null
                              ? DateHelper.displayDate(_selectedDay!)
                              : StringConstants.noDate,
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: ThemeConstants.bottomSheetTextColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CommonButton(
                          buttonText:StringConstants.cancel,
                          buttonColor: ThemeConstants.buttonColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          buttonTextColor: ThemeConstants.primaryColor,
                        ),
                        const PercentageSizeBox(
                          widthInPer: 3.92,
                        ),
                        CommonButton(
                            buttonText:StringConstants.save,
                            onPressed: () {
                              Navigator.pop(context, _selectedDay);
                            })
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  DateTime? handleDateButtonClick(int id) {
    final DateTime currentDateWithoutTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );

    switch (id) {
      case AppConstants.TODAY_INDEX:
        return (widget.firstDay != null &&
                currentDateWithoutTime.isBefore(widget.firstDay!))
            ? null
            : DateTime.now();
      case AppConstants.NEXT_MONDAY_INDEX:
        return DateHelper.findNextDay(DateTime.monday);
      case AppConstants.NEXT_TUESDAY_INDEX:
        return DateHelper.findNextDay(DateTime.tuesday);
      case AppConstants.AFTER_ONE_WEEK_INDEX:
        return DateHelper.findNextWeek();
      default:
        return DateTime.now();
    }
  }
}
