# WeatherApp

Mobile app where user can acquire information regarding current weather from any location in the world (that OpenWeatherMap API contains). 

- REST API - method GET utilized in the project: 
  - fetching weather from OpenWeatherMap Current Weather API, by either coords or location name (returns one weather record). 
  - fetching up to five locations from OpenWeatherMap Geolocation API by location name, used to display search results.
- BLoC used to manage app states and structure the code. Weather states are being stored locally and persist after closing the application. 
- Internet connection monitored.
- Weather requested is updated every minute, as there is a stream for fetching weather.



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
 <br />
 <br />
 <br />
 <p align="center">
 <img src="https://media3.giphy.com/media/e4Fzn1XmRhrf06TqhQ/giphy.gif?cid=790b7611914b298f476afde80b936a25f2f5fd9b92e616a3&rid=giphy.gif&ct=g"> 
 <br />
 <br />
  
 </p>
1. GIF shows that app state changes on textfield input, if its empty then we display the sun.gif, if there is text, there is weather suggestion displayed (if there is one for such textfield value), input must be longer than 2 characters for suggestion to appear. SearchBloc stores textfield value, adds an event on its change or when user requests search results and is responsible for what feature to show: 
 
 - state SearchInitial (show sun gif)
 - state SearchWithValue (show search bar only)
 - state SearchResultsLoaded(show search bar and results), 
 - state SearchSuggestionsLoaded(show search bar and suggestion).
 
 Weather suggestion only fetches when user is typing, not removing characters from the textfield.
 
 
 
 <br />
 <br />
 <br />
 <br />
 <p align="center">
 <img src="https://media1.giphy.com/media/bAS7Cl9p1rxPpc4ViP/giphy.gif?cid=790b761118dea5d92ce688110afb474ecbb2d672daba723b&rid=giphy.gif&ct=g"> 
 <br />
 <br />
 </p>
2. GIF shows client side validation (when textfield value < 2) and server side validation when user requests search results by clicking button ">". Also when user loses connection and wants to perform an operation to get results, a snackbar describing appropriate message pops up.
 
 <br />
 <br />
 <br />
 <br />
 <p align="center">
 <img src="https://media2.giphy.com/media/CPK2k5tH48JTFrdV3t/giphy.gif?cid=790b761187c9477f773ba1c5d3e0e6e75d01ab1b39b30679&rid=giphy.gif&ct=g"> 
 <br />
 <br />
 </p>
 3. GIF shows search results in case when there are some. User can click on any result (list tile) and get a weather screen displaying it.
 
 <br />
 <br />
 <br />
 <br />
 <p align="center">
 <img src="https://media1.giphy.com/media/v8qRvs90LI0mCnJFJk/giphy.gif?cid=790b76117d034545b0cb6137947e0a6c32a1443a79a780e1&rid=giphy.gif&ct=g"> 
 <br />
 <br />
 </p>
4. GIF shows weather screen. User is subscribed to weather fetching stream (every minute). When user closes the app and reopens it, the state persists. If user loses internet connection, he is unsubscribed from the weather stream. He can click a refresh button at the top of the screen to subscribe to weather stream again but it will only work if he has an internet connection established.
 


