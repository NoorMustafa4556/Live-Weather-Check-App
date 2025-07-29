# ☁️ Live Weather Check App

A feature-rich Weather App built with Flutter, providing real-time data from the OpenWeatherMap API. It includes a full user authentication system, a dynamic city search with suggestions, and a clean, modern UI. View temperature and conditions in a sleek, card-based design with beautiful gradient backgrounds.

---



## 🚀 Features

### 🔹 Splash Screen
-   Engaging entry point with a multi-color gradient background.
-   Features weather-related icons (sun, cloud) to set the theme.
-   Animated loading indicator using `flutter_spinkit` (`SpinKitWave`).
-   Automatically navigates to the signup screen after a short delay.

### 🔹 User Authentication (Signup & Login)
-   Clean and secure forms for user registration and login.
-   Custom-styled input fields for a consistent user experience.
-   Password visibility toggle to help users avoid typos.
-   Smooth navigation flow between signup and login pages.

### 🔹 Weather Home Page
-   Fetches and displays live weather data from the OpenWeatherMap API.
-   An intuitive search bar to find weather for any city worldwide.
-   Autocomplete feature suggests city names as you type.
-   Displays results in a modern, card-based layout on a beautiful gradient background.
-   Gracefully handles loading states and potential API errors.

---

## 🛠️ Tech Stack & Key Packages

-   **Framework:** [Flutter](https://flutter.dev/)
-   **Language:** [Dart](https://dart.dev/)
-   **API:** [OpenWeatherMap API](https://openweathermap.org/api)
-   **Key Packages:**
    -   [`http`](https://pub.dev/packages/http): For making network requests to fetch weather data.
    -   [`flutter_spinkit`](https://pub.dev/packages/flutter_spinkit): For beautiful loading animations.

---

## ⚙️ Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing.

### Prerequisites

Make sure you have the Flutter SDK installed on your machine. For help, check the official [Flutter installation guide](https://flutter.dev/docs/get-started/install).

### Installation & Setup

1.  **Clone the repository**
    ```bash
    git clone https://github.com/NoorMustafa4556/Live-Weather-Check-App.git
    ```

2.  **Navigate to the project directory**
    ```bash
    cd Live-Weather-Check-App
    ```

3.  **Install the dependencies**
    ```bash
    flutter pub get
    ```

4.  **Set up the API Key (Crucial Step!)**
    -   Get a free API key from [OpenWeatherMap](https://home.openweathermap.org/users/sign_up).
    -   In the `lib` directory, create a new file named `config.dart`.
    -   Add your API key to `lib/config.dart`:
        ```dart
        const String openWeatherApiKey = "YOUR_API_KEY_HERE";
        ```
    -   **Important:** Add `lib/config.dart` to your `.gitignore` file to keep your key secret.

5.  **Run the app**
    ```bash
    flutter run
    ```

---

## 🤝 Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1.  Fork the Project
2.  Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3.  Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4.  Push to the Branch (`git push origin feature/AmazingFeature`)
5.  Open a Pull Request

---

Made with ❤️ by Noor Mustafa
