# Country App Prototype

This Flutter application displays a list of countries, allows users to search for specific countries, view details about each country, and select a preferred language. It also includes a theme switching capability.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)
- [Contributing](#contributing)
- [License](#license)

## Features

- **Country Listing:** Displays a list of countries with their flags, names, and capitals.
- **Search Functionality:** Allows users to search for countries by name.
- **Country Details:** Provides detailed information about a selected country, including its official name, capital, continent, currency, and population.
- **Language Selection:** Allows the user to select their preferred language.
- **Theme Switching:** Toggles between light and dark themes.

## Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/Chukwuaebuka/prototype_country_app.git
    ```
2.  **Navigate to the project directory:**
    ```bash
    cd country_app_prototype
    ```
3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

## Usage

1.  **Run the app:**
    ```bash
    flutter run
    ```

## Dependencies

- `flutter`: The Flutter framework.
- `http`: For making HTTP requests to the REST Countries API.
- `provider`: For state management (used for theme switching).

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

_(Specify the license under which your code is distributed. For example: MIT License)_

---

### Code Explanation (HomeScreen - `lib/screens/home_screen.dart`)

The `HomeScreen` widget fetches country data from the REST Countries API, displays a list of countries, and allows users to search for specific countries. It uses a `FutureBuilder` to handle the asynchronous data fetching. The `_filterCountries` method implements the search functionality. The `LanguageSelectionModal` is triggered from this screen. It also integrates the ThemeProvider to handle theme changes.

### Code Explanation (DetailsScreen - `lib/screens/details_screen.dart`)

The `DetailsScreen` widget displays detailed information about a selected country. It receives the country name as a parameter and fetches the corresponding data from the REST Countries API. It also uses a `FutureBuilder` to handle the asynchronous data fetching.
