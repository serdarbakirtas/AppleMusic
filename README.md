# AppleMusic



## Proposed decision
***
The view architecture should be amended in the following ways:

- Identifiable
  > The identifiable is tied to the view and the view only.
- View
  > Main content, divided further views shown by application.
- Observed
  > The observed then the view will actually update itself automatically when the published variable is updated. 

## Code Style
***
+ Files are divided into following folders:
    - *Scenes* -> Architecture and repositories are here
    - *Model* -> Responses
+ Naming of files in views folder:
    - For Identifiable: Identifiable *Some*
    - For view: *Some* View
    - For Observed: *Some* View+Observed
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
    - // MARK: API Calls (for observed)

## Tech
***
+ Xcode 13.4.1
+ Supported iOS versions: 15
+ SwiftUI
+ Supported devices: iPhone - iPad (portrait and landscape orientation)

## Installation
[Xcode](https://developer.apple.com/download/all/?q=Xcode)

## Package Dependencies
[Kingfisher](https://github.com/onevcat/Kingfisher) 

## Some inspiring links

+ [Dependency Injection in Swift using](https://www.avanderlee.com/swift/dependency-injection/)
