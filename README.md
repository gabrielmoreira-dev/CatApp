<div align="center">
  <img alt="CatApp" width=250 src="./CatApp/Assets.xcassets/AppIcon.appiconset/AppIcon.png"/>
  
  # The CatApp
  <img src="https://img.shields.io/badge/iOS-17+-red"/>
  <img src="https://img.shields.io/badge/XCode-16+-red"/>

  **CatApp** is a modern iOS application that displays a list of cats from [The Cat API](https://thecatapi.com/). Built with SwiftUI, it combines performance and elegant design to deliver the best experience for cat lovers.
  
  <img alt="CatAppGIF" width=250 src="https://github.com/gabrielmoreira-dev/Resources/blob/main/CatApp_Dark.gif"/> 
</div>

## Setup Instructions
1. Obtain an API key by signing up at [The Cat API](https://thecatapi.com/).
2. Open the project in **Xcode 16** and open the `Configuration.xcconfig` file.
3. Replace the placeholder API key in the following line:
   ```plaintext
   API_KEY = <your_api_key>
   ```
4. Build and run the project on a simulator or a physical device.

## Project Dependencies
- The project was developed using **Xcode 16**.
- No external dependencies (CocoaPods or Swift Package Manager) are required.

## Running Unit and UI Tests
1. Open the **Test Navigator** in Xcode.
2. Run the tests for `CatApp` by clicking the **Run** button.

## Architectural Decisions
CatApp follows **Clean Architecture** along with the **MVVM (Model-View-ViewModel)** design pattern to ensure scalability, maintainability, and separation of concerns.

### Clean Architecture Layers
1. **Presentation Layer (SwiftUI Views & ViewModels)**
   - Handles UI rendering and user interactions.
   - ViewModels manage state and format data for the UI.

2. **Domain Layer (Use Cases & Business Logic)**
   - Contains the core business logic and use cases.
   - Acts as an intermediary between the Presentation and Data layers.

3. **Data Layer (Repositories & Network Services)**
   - Fetches data from external sources (The Cat API).
   - Implements the repository pattern to abstract data sources.

This approach ensures a clear separation of concerns, making the application modular, testable, and easy to maintain.

## Author

- Gabriel Moreira - <a href="https://github.com/gabrielmoreira-dev">@gabrielmoreira-dev</a>

