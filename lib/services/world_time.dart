import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time = '';
  String countryFlag;
  String timezone;  // for example: Africa/Nairobi, Europe/London

  //constructor
  WorldTime({required this.location, required this.countryFlag, required this.timezone});

  Future<void> getTime() async {
    try {
      // WorldTimeAPI request
      Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$timezone'));
      Map data = jsonDecode(response.body);

      //  getting response attributes
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      DateTime currentDate = DateTime.parse(datetime);
      currentDate = currentDate.add(Duration(hours: int.parse(offset)));

      time = DateFormat.jm().format(currentDate);   // set time property

    }
    catch (e) {
      print('An error occurred! $e');
      // update time since it will ne null
      time = 'Could not get time data';
    }

  }
}

WorldTime instance = WorldTime(location: 'Nairobi', countryFlag: 'kenya.png', timezone: 'Africa/Nairobi');