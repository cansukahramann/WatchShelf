# WatchShelf

WatchShelf is a movie and series tracking iOS application designed to help users discover, organize, and explore detailed information about their favorite movies and series. It is built with the MVVM architecture and uses data from  [The Movie Database](https://www.themoviedb.org/). The app is created with Swift Package Manager (SPM) and has its own network layer.

## General Features

- **MVVM Architecture**: Provides a clear separation of concerns by dividing the application into Model, View, and ViewModel layers, ensuring a maintainable codebase.
- **UIKit**: The application's user interface is fully implemented using UIKit.
- **UI Design**: The entire user interface is developed entirely programmatically.
- **FileManager**: A local storage solution is used to save liked content for movies and series by encoding the data into JSON and saving it to the app's documents directory. This ensures persistence of the watchlist across app launches.
- **Loading View**: Shows a progress HUD to indicate that data is being loaded, enhancing the user experience by providing visual feedback during content fetching.
- **Lottie Animations**: Utilizes Lottie animations to enhance the user experience with dynamic visuals.
- **Network Layer**: The network layer is built with Moya for cleaner and more manageable API requests. It uses a MoyaProvider to handle requests and integrates Alamofire for additional networking capabilities. The layer includes error handling for connection issues and invalid status codes. A custom ResponseMapper decodes API responses into Swift models using `Decodable`, ensuring type safety and readability. The `TargetType` protocol is extended to centralize API configuration, including base URL and headers, simplifying endpoint management.

## UI Architecture and Design

- **Programmatic Development**: The entire application, including its user interfaces and functionality, has been developed programmatically. This approach provides greater flexibility, reusability, and customization opportunities.

## Libraries Used

- **Moya**: For networking
- **KingFisher**: For image downloading and caching
- **Lottie**: For animations
- **ProgressHud**: Used to inform users about the loading status while data is being fetched

## Splash View

This is the welcome screen displayed every time the application is opened. It features custom animations created manually using Swift code.

## Main Views (Movies - TV Shows)

### Movie

The Movie screen is the first tab in the tab bar. The films are organized into four distinct categories: Popular, Now Playing, Upcoming, and Top Rated.
- Users can access the categories more quickly.
- The UI is entirely built programmatically.

<img src="https://github.com/user-attachments/assets/d772f86b-8cb2-4fad-98b6-2c3f0bc7cb7e" width="500" />




### TV Show

This screen is the second tab in the tab bar. The TV shows are organized into four distinct categories: Airing Today, On the Air, Popular, and Top Rated.
- Users can access the categories more quickly.
- The UI is entirely built programmatically.

## Movie Detail Screen

This screen allows users to access detailed information about a specific movie. It is fully implemented programmatically and includes the following features:

The Movie Detail screen is structured by combining various views, including a header view with the movie poster, title, and properties, a description view, a trailer link (if available), a cast team section, and a similar movies section, all organized within a stack view for a clean and cohesive layout.

### Top Section:
- **Movie Poster and Details**:
  - The movie poster is displayed on the left side.
  - On the right side, the movie title, release date, genres (e.g., Science Fiction, Action, Adventure), duration, and user rating are shown.
  - A "+" icon is available to add the movie to the WatchList.
- **Description Text**:
  - A short description of the movie is provided.
  - If the description is lengthy, it can be expanded or collapsed using "Read More" and "Read Less" buttons.

### Middle Section:
- **Trailer or Video Section**:
  - A YouTube video or trailer related to the movie is embedded and displayed here.

### Bottom Section:
- **Cast**:
  - Prominent cast members are displayed with their photos, names, and the characters they portray (e.g., "Tom Hardy - Eddie Brock / Venom").
- **Similar Movies**:
  - Recommended similar movies are shown in a horizontal list with their posters.

## TV Show Detail Screen

This screen allows users to access detailed information about a specific TV show. It is fully implemented programmatically and includes the following features:

The TV Show Detail screen is structured by combining various views, including a header view with the TV show poster, title, and properties, a description view, a trailer link (if available), a cast team section, and a similar TV shows section, all organized within a stack view for a clean and cohesive layout.

### Top Section:
- **TV Show Poster and Details**:
  - The TV show poster is displayed on the left side.
  - On the right side, the TV show title, first air date, genres (e.g., Drama, Comedy, Thriller), duration, and user rating are shown.
  - A "+" icon is available to add the TV show to the WatchList.
- **Description Text**:
  - A short description of the TV show is provided.
  - If the description is lengthy, it can be expanded or collapsed using "Read More" and "Read Less" buttons.

### Middle Section:
- **Trailer or Video Section**:
  - A YouTube video or trailer related to the TV show is embedded and displayed here.

### Bottom Section:
- **Cast**:
  - Prominent cast members are displayed with their photos, names, and the characters they portray (e.g., "Sarah Paulson - Cordelia Goode").
- **Similar TV Shows**:
  - Recommended similar TV shows are shown in a horizontal list with their posters.

## Category Scene

This screen displays all movie and TV show categories (e.g., Action, Western) fetched from the API. Once a category is selected, the relevant movies for that category are listed. In the top right corner, users can switch between movies and TV shows using a filtering option.

The Category screen is fully implemented programmatically and includes the following features:
- **Category Cells**: Each category is displayed in a list, with a tap animation applied to category cells for a more dynamic interaction.
- **Filtering**: A filter option is available in the top right corner, allowing users to toggle between movies and TV shows. This is implemented using `UIMenu`, providing an intuitive interface for switching content types.
- **Components**: Each component of the screen is designed as independent modules, which are then combined in the main view.

This screen provides a smooth and interactive experience for users to explore different categories and switch between movie and TV show content effortlessly.

## Search Scene

This screen displays random content. Users can search for movies or TV shows using the Search bar.

The content listed after the search is shown using a TableView. The screen is fully implemented programmatically and includes the following features:
- **Compositional Layout**: The user interface is designed using compositional layout, providing a flexible and dynamic structure.
- **Search Bar**: Users can search for specific movies or TV shows through the search bar.
- **TableView**: After searching, the results are displayed in a structured and orderly manner using TableView.
- **Components**: Each component of the screen is designed as independent modules, which are then combined in the main view.

This screen allows users to search for content quickly and efficiently, while providing a clean and dynamic user experience.
