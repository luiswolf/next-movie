# Next Movie App

Challenge for iOS Developer position at ArcTouch 

> **PROJECT DESCRIPTION**
>
> As a mobile engineer you've been tasked with the development of an app for cinephiles and movie
hobbyists. This first version (MVP) of the app will be very simple and limited to show the list of
upcoming movies. The app will be fed with content from The Movie Database (TMDb). No design specs
were given, so you're free to follow your UX and UI personal preferences. However the app should work
both in landscape and portrait orientations. The choice of platform (iOS, Android, Xamarin) and
development approach is also for you to decide based on previous experience and/or personal interest.
>
> **FUNCTIONAL REQUIREMENTS**
> 
> The first release of the app will be very limited in scope, but will serve as the foundation for future
releases. It's expected that user will be able to:
> * Scroll through the list of upcoming movies - including movie name, poster or backdrop image,
genre and release date. List should not be limited to show only the first 20 movies as returned
by the API.
> * Select a specific movie to see details (name, poster image, genre, overview and release date).
> * (Optional) Search for movies by entering a partial or full movie name.
>
> **TECHNICAL REQUIREMENTS**
> 
> You should see this project as an opportunity to create an app following modern development best
practices (given your platform of choice), but also feel free to use your own app architecture
preferences (coding standards, code organization, third-party libraries, etc).
A TMDb API key is already available so you don't need to request your own:
1f54bd990f1cdfb230adb312546d765d.
The API documentation and examples of use can be found here:
> * https://developers.themoviedb.org/3
>
> Feel free to use package/dependency managers (ex: Maven, CocoaPods, etc) if you see fit.

The Next Movie app was developed to attend the challenge requirements with a great focus on the design of the movie detail screen, native usage, project architecture, best practices and some extras.

I chose the iOS 10 as the minimun version for the application, but there's nothing specific for this version that can't be implemented on older iOS versions.

For this kind of application, that has a master view showing a list of itens and a detail view of an item, I used to choose the Master-Detail App Xcode template, because it's faster to setup the project and brings the UISplitViewController that shows both views on iPad, but I decided to create a Single View Application project and implement the UISplitViewController by myself, because one challenge's premise is to keep the code clean and easy to maintain and extend. 
I used the RootViewController pattern that is clean and simple to extend and implement another concepts to the project without necessity of major project restructuring.

The due period of the challenge was 5 days, but I used around 20 hours to do it, during the period between 11/24/2018 and 11/29/2018.

## Requirements

* iOS 10.0+
* Xcode 10.1+
* Swift 4.2.1+

## Dependencies

3rd-party libraries used:

* [Alamofire] - Library to make network requests to the TMDb database
* [ObjectMapper] - Library that parses the JSON responses to Swift objects
* [UIImageColors] - Class that gets the main colors of an image

[Alamofire]: <https://github.com/Alamofire/Alamofire>
[ObjectMapper]: <https://github.com/tristanhimmelman/ObjectMapper>
[UIImageColors]: <https://github.com/jathu/UIImageColors>

## App presentation

### Splash screen

This screen was developed to simple show a loader while the application loads the necessary content to use in the main areas of the application. This screen can also be used to decide the application flow based on some future situations, like check the user is logged in or make validations. By now, the screen just loads the list of movie genres that will be used in the movie list, because the upcoming movie list endpoint doesn't return the description of the movie genres.

<img src="screenshots/movie-splash-01.png" width="250">

### Movie list

This is the main screen of the app. This screen shows the upcoming movies returned by the TMDb API. 
The basic data shown are: movie title, release date, movie genres and the poster of the movie.
As long as the user scrolls down the screen, new itens are shown. The app makes requests for each 20 itens while the API returns.

<img src="screenshots/movie-list-01.png" width="250"><img src="screenshots/movie-list-02.png" width="250">

*** 

The user can also search for a specific movie by the native iOS search bar presented at the navigation bar.

<img src="screenshots/movie-list-search-02.png" width="250">

**PS. The main movie list make requests from the movie/upcoming API endpoint. The search make requests from the search/movie API endpoint**

*** 

If a network request fails, a generic error screen is show to the user.

<img src="screenshots/movie-list-error-01.png" width="250">

### Movie detail

The movie detail screen shows the basic details of the movie (Title, original title, genres, rating, release date and overview).
In this screen was used a library/class that gets the main colors of an image. It was used to show a custom apperance according to the chosen movie.

<img src="screenshots/movie-detail-01.png" width="250"><img src="screenshots/movie-detail-02.png" width="250"><img src="screenshots/movie-detail-04.png" width="250">

### Movie detail - Landscape mode

As the user changes the orientation of the device (iPhone), is shown an interface a little different, keeping the movie poster fixed at left while the user can see the movie informations scrolling at right.

<img src="screenshots/movie-detail-03-portrait.png" width="250"><img src="screenshots/movie-detail-03-landscape.png" width="500">

### iPad

The application also was developed to iPad users, where both movie list and movie detail are shown by the UISplitViewController.

<img src="screenshots/ipad-01.png" width="500">

### Extra: Internationalization

As the application was developed in English language but it will be probably tested in Brazil, I decided to include the internalization to the Brazilian Portuguese language. 
The internationalization considers the user's device preffer language to display the content. These languages are also used to get appropriate data within the TMDb API.

<img src="screenshots/movie-list-portuguese-01.png" width="250"><img src="screenshots/movie-list-portuguese-02.png" width="250">

## Requirements checklist

- [x] Specify the used plataform
- [x] Public repository
- [x] Development branch
- [x] Screenshots
- [x] Pull request to master branch
- [x] Clean code
- [x] Best practices
- [x] TMDb API usage
- [x] Responsive layout (portrait/landscape)
- [x] Upcoming movies list screen (showing the movie name, poster or backdrop image, genre and release date)
- [x] Movie detail screen (showing the movie name, poster, genre, overview and release date)
- [X] Pagination
- [X] Search for partial or full movie name
- [X] Compile and run without errors
