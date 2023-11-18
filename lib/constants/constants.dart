import 'package:employee_app/constants/string_constants.dart';
import 'package:employee_app/widget/date_button_model.dart';

class AppConstants {
  static const IC_CALENDAR_LEFT = 'assets/images/calendar_left.png';
  static const IC_CALENDAR_RIGHT = 'assets/images/calendar_right.png';
  static const IC_PERSON = 'assets/images/person.png';
  static const IC_CALENDAR = 'assets/images/calendar.png';
  static const IC_ROLE = 'assets/images/role.png';
  static const IC_DROP_DOWN = 'assets/images/drop_down.png';
  static const IC_FORWARD = 'assets/images/forward.png';
  static const IC_DELETE = 'assets/images/delete.png';
  static const IMG_NO_EMPLOYEE = 'assets/images/empty_employee.png';

  static const NO_DATE_INDEX = 1;
  static const TODAY_INDEX = 2;
  static const NEXT_MONDAY_INDEX = 3;
  static const NEXT_TUESDAY_INDEX = 4;
  static const AFTER_ONE_WEEK_INDEX = 5;

  static List<DateButtonModel> fromDateButtonList = [
    DateButtonModel(id: TODAY_INDEX, title: StringConstants.today, isSelected: true),
    DateButtonModel(id: NEXT_MONDAY_INDEX, title: StringConstants.nextMonday),
    DateButtonModel(id: NEXT_TUESDAY_INDEX, title: StringConstants.nextTuesday),
    DateButtonModel(id: AFTER_ONE_WEEK_INDEX, title: StringConstants.afterWeek),
  ];

  static List<DateButtonModel> toDateButtonList = [
    DateButtonModel(id: NO_DATE_INDEX, title:StringConstants.noDate, isSelected: true),
    DateButtonModel(id: TODAY_INDEX, title: StringConstants.today),
  ];

}
