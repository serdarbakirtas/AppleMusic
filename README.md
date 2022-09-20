# AppleMusic

## Proposed decision
***
Clean Architecture: The view architecture should be amended in the following ways:

- State
  > View State is the only entity in the pattern that requires to be an object, specifically, an ObservableObject. View State should be value types: the value of the State view represents the data currently displayed in the view. 
  Just like with Redux, AppState works as the single source of truth and keeps the state for the entire app, including user’s data, authentication tokens, screen navigation state (selected tabs, presented sheets) and system state (is active / is backgrounded, etc.)
- View
  > Views should observe Interactor and react to any changes in their value. This is the usual SwiftUI’s view. It may be stateless or have local @State variables. No other layers know about the View layer existence, so there is no need to hide it behind a protocol. When the view is instantiated, it receives AppState and Interactor through the SwiftUI’s standard dependency injection of a variable attributed with @Environment, @EnvironmentObject or @ObservedObject. Side effects are triggered by the user’s actions (such as a tap on a button) or view lifecycle event onAppear and are forwarded to the Interactor.
- Interactor
  > Interactor should observe changes to the view state. Interactor encapsulates the business logic for the specific View or a group of views. Together with the AppState forms the Business Logic layer, that’s fully independent of the presentation and the external resources. It is fully stateless and only refers to the AppState object, injected as a constructor parameter. Interactors should be “facaded” with a protocol so that the View could talk to a mocked Interactor in tests. Interactors receive requests to perform work, such as obtaining data from an external source or making computations, but they never return data back directly, such as in a closure. Instead, they forward the result to the AppState or a Binding provided by the View. The Binding is used when the result of work (the data) is owned locally by one View and does not belong to the central AppState, that is, it doesn’t need to be persisted or shared with other screens of the app.

<img src="https://raw.githubusercontent.com/nalexn/blob_files/master/images/swiftui_arc_001_d.png" alt="HTML5 Icon" width="800" height="334">

# Rationale
***
It does provide a view architecture that can decouple view state from view actions allowing important refactoring to take place to both enable SwiftUI previews and cover views with snapshot tests. It also simplifies view models which are now view state values. However, both the need to explicitly observe changes to the view model and the continued "misuse" of the state property wrapper to ensure that only one instance of the controller is created are areas for improvement.

## Code Style
***
+ Files are divided into following folders:
    - *Scenes* -> All UI and Business logic
    - *Model* -> Responses
+ Naming of files in views folder:
    - For interactor: *Some*Interactor
    - For view: *Some*View
    - For view state: *Some*ViewState
+ Naming of functions:
    - Basic functions start with verbs (i.e. loadData())
    - Actions/Listeners usually start with 'on' (i.e. onLoadData())
+ '// MARK:' feature should be used to divide different portions of the code. The order should be like:
    - // MARK: Properties
        + static let
        + let/var
        + @ Published
    - // MARK: Functions (other functions used in a class)
        + Always put private keyword if func is used only in that class
    - // MARK: API Calls (for interactor)

## How to Generate Apple Music Token
***
+ [rudrank.blog](https://rudrank.blog/postman-apple-music-api)
+ [SwiftJWTSample](https://github.com/klaas/SwiftJWTSample)

## Tech
***
+ Xcode 13.4.1
+ Supported iOS versions: 15.0
+ SwiftUI
+ Supported devices: iPhone - iPad (portrait and landscape orientation)

## Installation
[Xcode](https://developer.apple.com/download/all/?q=Xcode)

## Some inspiring links

+ [The Clean Code Blog](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
+ [Clean Architecture for SwiftUI](https://nalexn.github.io/clean-architecture-swiftui/)
+ [Dependency Injection in Swift using](https://www.avanderlee.com/swift/dependency-injection/)

# Screens
<img src="https://github.com/serdarbakirtas/AppleMusic/blob/release/Screenshots/Songs.png" alt="HTML5 Icon" width="276" height="598"> <img src="https://github.com/serdarbakirtas/AppleMusic/blob/release/Screenshots/MusicPlay.png" alt="HTML5 Icon" width="276" height="598"> 

https://user-images.githubusercontent.com/4365303/191203936-0075ea5e-307f-4c7c-8d31-6c84c30c6f6b.mov

