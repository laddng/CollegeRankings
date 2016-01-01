# CollegeRankings
Philip Handwerk from the Office of the Provost at Wake Forest University started a project for a mobile application that would help high school students and their parents with their college search process. As a user, one is given 11 questions about universities that they answer in the app. Based on their responses, the app calculates a list of universities that best fit them. Users can then see the details of those universities, and filter their survey results. The data is pulled from a government database that has detailed information for over 2,000+ universities in the United States.

---

### Application Layout
There are three main areas of the application, including:
*	Terms and Conditions process
*	Tutorial process
*	Survey, university results, detail pages, and filter options

  #### Terms and Conditions

  The Terms and Conditions is a screen that is prompted when the user first uses the app. Once the user agrees to the Terms and Conditions, it will disappear and save the user’s response locally. The next time the user uses the app, they will not have to see the Terms and Conditions screen. They way the caching works is that when the app opens up, in AppDelegate there is a line that checks to see if the user has accepted the terms by locating the file on local disk. If the file was not located, then the app prompts the user to accept the Terms and Conditions. If the file was located, then the app loads the tutorial screen.

  #### Tutorial of CollegeRankings

  Once the user has made it through the Terms and Conditions screen, they are prompted with a short tutorial about the app. This, like the Terms and Conditions screen, only appears if they user has never completed the tutorial. If the user has completed the tutorial before, the app automatically moves onto the main screen of the application. The Tutorial screen is a series of Page View Controller views that swipe easily and give the user clear instructions about the app before they first use it. Within each Page view, there is a screenshot of an iPhone with a certain screen of the app and a description of what the purpose of that screen is for. Users can choose to “Skip” the tutorial and move onto the main part of the application. Once the user has made it through the tutorial screens, the Tutorial view controller saves a file to disk that states that the user has learned about the features of the app. This file is checked the next time the app loads.
