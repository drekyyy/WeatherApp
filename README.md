# WeatherApp ENGLISH VERSION ONLY, I suppose there is no need for polish one :)

Mobile app where user can acquire information regarding current weather from any location in the world (that OpenWeatherMap API contains). 

o REST API - method GET utilized in the project: 
  - fetching weather from OpenWeatherMap Current Weather API, by either coords or location name (returns one result). 
  - fetching up to five locations from OpenWeatherMap Geolocation API by location name, used to display search results.
 
o BLoC used to manage app states and structure the code. Weather states are being stored locally and persist after closing the application. 
o Internet connection monitored.
o Weather requested is updated every minute, as the stream for weather fetching is responsible for it.

used tools (`pubspec.yaml`):
- `flutter_bloc: ^8.1.1`(bussiness logic component, responsible for state management and accessing data between screens, also a design pattern and architecture).
- `equatable: ^2.0.3` (tool for bloc, enables emitting state of the same name twice in a row, by comparing the props array).
- `connectivity_plus: ^2.3.6+1`(tool for managing internet connection, you can listen to a stream that returns whether you are connected (by wifi or mobile), or disconnected).
- `hydrated_bloc: ^8.1.0` (extension to bloc, automatically persists and restores bloc and cubit states. I use it in WeatherCubit).
- `path_provider: ^2.0.11` (provides path to commonly used locations on the filesystem).
- `http: ^0.13.5` (used to easily consume http resources, used for getting data from OpenWeatherMap API (Current Weather and Geolocation)).
- `flutter_spinkit: ^5.1.0` (loading animations, when waiting for data from the server).
- `intl: ^0.17.0` (used to format dates, to display a month name instead of a month number eg (02 = February)).
- `flutter_launcher_icons: ^0.10.0` (used to set custom icon of the app).

