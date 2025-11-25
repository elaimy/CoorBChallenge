Countries App

This is a small iOS app I built as part of a coding challenge.
The goal was to fetch a list of countries, let the user pick up to 5, save them locally, and show a simple details screen.

I used SwiftUI, MVVM, and a few lightweight services for networking, storage, and location.

What the app does
	•	Loads all countries from the REST Countries API
	•	Lets the user search through the list
	•	Allows selecting up to 5 countries
	•	Shows the selected ones at the top
	•	Swipe left on any selected country to remove it
	•	Saves selections locally so they stay after closing the app
	•	On first launch, it tries to detect the user’s country using location
	•	Each country has a simple detail screen with its flag, capital, region, and currency

Tech used
	•	Swift 5
	•	SwiftUI
	•	MVVM + Dependency Injection
	•	Protocol-oriented services (Network, Storage, Location)
	•	UserDefaults for persistence
	•	Unit tests for networking and view model logic

How to run it

Just open the project in Xcode and run it on any iPhone simulator.
No setup required.
