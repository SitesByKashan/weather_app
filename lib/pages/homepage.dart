
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/api.dart';
import 'package:weather_app/main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiResponse? response;
  bool inProgress = false;
  String message = "Search for the location to get weather data";
  String lat  = "";
  String long =  "";
  
  _getCurrentLocation() async{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      return Future.error('Location Service not Avaible');
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location Permission Denied');
      }
    }
    if(permission == LocationPermission.deniedForever){
      return Future.error('Location Denied Permanently');
    }
    return Geolocator.getCurrentPosition();
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation().then((value){
        lat = '${value.latitude}';
        long = '${value.longitude}';
        Run = '${value.longitude}';
    }); 
  }

  set Run(String x ){
  _getWeatherData('$lat,$long');
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(
    children: [
      Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1f274b),
              Color(0xFF933dac),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.8,
              1
            ],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 50,),
            _buildSearchWidget(),
            const SizedBox(height: 20),
            if (inProgress)
              const CircularProgressIndicator()
            else
              Expanded(
                  child: SingleChildScrollView(child: _buildWeatherWidget())),
          ],
        ),
      ),
    ],
          ),
        );
  }

  Widget _buildSearchWidget() {
    return TextField(
      style: const TextStyle(color: Colors.white),
      onSubmitted: (value) {
        _getWeatherData(value);
      },
      decoration: const InputDecoration(
          suffixIcon: Icon(Icons.search,color: Colors.white,) ,
           hintText: "Location",
           border: OutlineInputBorder(
           borderSide: BorderSide(
           width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20),                 
          ),
        ),
      ),  
    );
  }

  Widget _buildWeatherWidget() {
    if (response == null) {
      return Text(message,style: const TextStyle(color: Colors.white),);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                color: Colors.white,
                Icons.location_on_outlined,
                size: 50,
              ),
              Text(
                response?.location?.name ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                response?.location?.country ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
         
          Center(
            child: SizedBox(
              height: 200,
              child: Image.asset(
                MyImages.logoImage
              ),
            ),
          ),
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "${response?.current?.tempC.toString() ?? ""} °c",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                (response?.current?.condition?.text.toString() ?? ""),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Card(
            elevation: 4,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget("Humidity",
                        response?.current?.humidity?.toString() ?? ""),
                    _dataAndTitleWidget("Wind Speed",
                        "${response?.current?.windKph?.toString() ?? ""} km/h")
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _dataAndTitleWidget(
                        "UV", response?.current?.uv?.toString() ?? ""),
                    _dataAndTitleWidget("Percipitation",
                        "${response?.current?.precipMm?.toString() ?? ""} mm")
                  ],
                ),
               
              ],
            ),
          )
        ],
      );
    }
  }

  Widget _dataAndTitleWidget(String title, String data) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          Text(
            data,
            style: const TextStyle(
              fontSize: 27,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _getWeatherData(String location) async {
    setState(() {
      inProgress = true;
    });

    try {
      response = await WeatherApi().getCurrentWeather(location);
    } catch (e) {
      setState(() {
        message = "Failed to get weather ";
        response = null;
      });
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}

