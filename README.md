## Code Style
***
+ Files are divided into following folders:
    - *Protocols* -> Protocols that are used overall in the app
    - *Views* -> main content, divided further views shown by application
    - *Model* -> simple object classes, mostly conforms to database objects
    - *viewmodels* -> classes that represents shown data in ui, they are created from model objects 
+ Order of the files in views folder should be:
    - Table/Collection View Cell
    - View Controller
    - Presenter
+ Naming of files in views folder:
    - For table/collection cells: *Some*Cell
    - For view controllers: *Some*ViewController
    - For presenters: *Some*Presenter
+ Naming of functions:
    - Basic functions start with verbs (i.e. loadVehicle())
    - Actions/Listeners usually start with 'on' (i.e. onLoadVehicle())
+ '// MARK:' feature should be used to divide different portions of the code. The order should be like:
    - // MARK: Properties
        + static let
        + let/var
        + @ IBOutlet
    - // MARK: Actions (for views)
        + @ IBAction
    - // MARK: Functions (other functions used in a class)
        + Always put private keyword if func is used only in that class
    - // MARK: API Calls (for presenters)

## Dependency Management
***
+ To add a library:
    - Add "pod '_libraryname_'" to "Podfile" in the project
    - Run "pod install" from terminal
        + You can check the difference between 'pod install' and 'pod update' at [cocoaPods guides](https://guides.cocoapods.org/using/pod-install-vs-update.html)
        + If pod is not installed, run "sudo gem install cocoapods" first
+ To update a library:
    - Change the version number of the library in "Podfile"
    - Run "pod update {libraryname}" 
+ To check outdated libraries
     - Run "pod outdated"

## Overview
***
+ Xcode 12.0.1
+ iOS Deployment Target 11.0
+ Swift 5
