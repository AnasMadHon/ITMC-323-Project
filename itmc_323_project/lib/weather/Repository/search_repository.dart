import 'package:dio/dio.dart';
import 'package:itmc_323_project/weather/models/model.dart';


class WeatherRepository {
  final dio = Dio();

  var url = "https://weatherapi-com.p.rapidapi.com/current.json";
  var apiKey = "07c2dff7e9msh5220551122f1450p1ce299jsnd53257de907a";

  Future<WeatherModel> getWeather(String city) async {
    try {
      var response = await dio.get(url,
          queryParameters: {"q": city},
          options: Options(headers: {
            "x-rapidapi-key": apiKey,
            "x-rapidapi-host": "weatherapi-com.p.rapidapi.com"
          }));
      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception("Failed to load weather data");
      }
    } catch (e) {
      if (e is DioException) {
        throw Exception(e.response!.data['error']['message'].toString());
      } else {
        throw Exception("An error occurred");
      }
    }
  }
}
