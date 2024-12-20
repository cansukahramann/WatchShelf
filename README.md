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

The entire application, including its user interfaces and functionality, has been developed programmatically. This approach provides greater flexibility, reusability, and customization opportunities.

## Libraries Used

- **Moya**: For networking
- **KingFisher**: For image downloading and caching
- **Lottie**: For animations
- **ProgressHud**: Used to inform users about the loading status while data is being fetched

## Splash View

This is the welcome screen displayed every time the application is opened. It features custom animations created manually.

https://github.com/user-attachments/assets/3157d87c-9c3c-4b5a-a7c2-548bcd38d32a


## Main Views (Movies - TV Shows)

### Movie

The Movie screen is the first tab in the tab bar. The films are organized into four distinct categories: Popular, Now Playing, Upcoming, and Top Rated.
- Users can access the categories more quickly.
- The UI is entirely built programmatically.

<p style="display: flex;">
  <img src="https://github.com/user-attachments/assets/d772f86b-8cb2-4fad-98b6-2c3f0bc7cb7e" width="250" />
  <img src="https://github.com/user-attachments/assets/113d51af-c80d-4a47-b1c0-f11f6611af6c" width="250" />
</p>


### TV Show

This screen is the second tab in the tab bar. The TV shows are organized into four distinct categories: Airing Today, On the Air, Popular, and Top Rated.
- Users can access the categories more quickly.
- The UI is entirely built programmatically.

<p style="display: flex;">
  <img src="https://github.com/user-attachments/assets/6c11e1dc-82b5-4f4f-b46d-2cbad86da5a5" width="250" />
  <img src="https://github.com/user-attachments/assets/a955c7de-34ca-461b-b3c9-88d9b7f32998" width="250" />
</p>


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

<p style="display: flex;">
  <img src="https://github.com/user-attachments/assets/7ff32996-c20a-4d59-8148-624808a3fe21" width="250" />
  <img src="https://github.com/user-attachments/assets/6650811e-a757-4a40-b872-d67c67c10e7c" width="250" />
</p>


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

<p style="display: flex;">
  <img src="https://github.com/user-attachments/assets/0df9a55f-2951-489d-a524-9b3383f4c424" width="250" />
  <img src="https://github.com/user-attachments/assets/9373cba5-879d-4e64-989e-e03c08a14586" width="250" />
</p>

## Cast Detail Screen

This screen displays the cast's photo, birthdate, birthplace, biography, and the movies and TV shows they have appeared in (if available). The screen is fully implemented programmatically, with all components created separately and organized using a **Stack View** for a clean and structured layout.

<p style="display: flex;">
  <img src="https://github.com/user-attachments/assets/68bffa9a-88ff-422c-9d4a-3b84284cc970" width="250" />
  <img src="https://github.com/user-attachments/assets/7aed9b81-073a-4d8b-87d5-4ee2e7c181ef" width="250" />
</p>


## Category Screen

This screen displays all movie and TV show categories (e.g., Action, Western) fetched from the API. Once a category is selected, the relevant movies for that category are listed. In the top right corner, users can switch between movies and TV shows using a filtering option.

The Category screen is fully implemented programmatically and includes the following features:
- **Category Cells**: Each category is displayed in a list, with a tap animation applied to category cells for a more dynamic interaction.
- **Filtering**: A filter option is available in the top right corner, allowing users to toggle between movies and TV shows. This is implemented using `UIMenu`, providing an intuitive interface for switching content types.
- **Components**: Each component of the screen is designed as independent modules, which are then combined in the main view.

This screen provides a smooth and interactive experience for users to explore different categories and switch between movie and TV show content effortlessly.

<p style="display: flex;">
  <img src="https://github.com/user-attachments/assets/eb563b14-b371-4676-a2e8-6511228f9bc9" width="250" />
  <img src="https://github.com/user-attachments/assets/2c72311c-bb9b-4c6d-9540-e5d785ad31f5" width="250" />
  <img src="https://github.com/user-attachments/assets/bb69f72d-4a21-4bb9-8b34-2acf5bd17f84" width="250" />
</p>


## Search Screen

This screen displays random content. Users can search for movies or TV shows using the Search bar.

The content listed after the search is shown using a TableView. The screen is fully implemented programmatically and includes the following features:
- **Compositional Layout**: The user interface is designed using compositional layout, providing a flexible and dynamic structure.
- **Search Bar**: Users can search for specific movies or TV shows through the search bar.
- **TableView**: After searching, the results are displayed in a structured and orderly manner using TableView.
- **Components**: Each component of the screen is designed as independent modules, which are then combined in the main view.

This screen allows users to search for content quickly and efficiently, while providing a clean and dynamic user experience.

<p style="display: flex;">
  <img src="https://github.com/user-attachments/assets/0ed854a8-b5cd-4336-951a-bcbbf076090d" width="250" />
  <img src="https://github.com/user-attachments/assets/9fa85062-b8b6-4c32-8537-1831ca011a27" width="250" />
</p>


## WatchList Screen

This screen lists the movies and TV shows liked by the user using **FileManager**. The content is displayed in a **TableView**. The screen is **fully designed programmatically**, with all components created and assembled without the use of Interface Builder.

The screen is **fully implemented programmatically** and includes the following features:

- **FileManager**: The user's liked movies and TV shows are stored in local storage using FileManager and then listed.
- **TableView**: The liked content is displayed in an organized and structured manner using TableView.
- **Lottie Animation**: When the list is empty, a Lottie animation is displayed to provide a dynamic and engaging user experience.

This screen provides users with an easy way to view and manage their favorite content.

<p style="display: flex;">
  <img src="https://github.com/user-attachments/assets/a42a702b-30cd-4b1a-970c-2dd170f31e43" width="250" />
  <img src="https://github.com/user-attachments/assets/42767435-018a-4bbc-9f2b-66b81dc714b5" width="250" />
</p>


