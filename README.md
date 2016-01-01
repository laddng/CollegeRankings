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

  #### Survey Screen
  
  The Survey screen consists of 11 questions and sliders. Users are asked to move the slider to respond to the questions about what they are looking for in universities. We chose to use sliders instead of textboxes with numbers because we wanted to provide a better user experience where users could quickly and effortlessly swipe to respond to the questions. If users are confused, they can press the “i” to get more information about a particular question. The sliders are all relative to each other, and so the value of each slider is divided by the total overall value given, weighing the responses against each other. When the user presses “Finish”, the values of the sliders are then sent to the algorithm in the next view controller, which calculates the results of universities.

  #### Results Screen

  When the results view controller is loaded, the view controller takes the values of the sliders passed on from the survey view controller and places it into an algorithm. This algorithm calculates the slider values against a database of scores given to every university in the United States. Once the scores for each university is calculated in response to the slider values, the algorithm then sorts the universities based on their scores and returns it to the table view. The results table view lists 10 schools at a time, and the rankings are shown. Users can search or filter these results as they chose. In addition, they can go to detail pages about each university and find helpful data about that particular school.

  #### Detail Screen
  
  There is a detail view controller that displays details about a particular university that was listed in the results view. The details are data pulled from the database of universities, and it includes tuition, enrollment, and other public information about that university. Users can visit the university website from the link in the detail view to get even more information about that university. This data is populated in a table view controller, and the data has been formatted in either currency amounts or enrollment size.

  #### Filter Screen

  Users can chose to filter their results by state, university type, enrollment size, or tuition costs.

  These filters are sent back to the results view controller once they are picked, and they can be changed or cleared anytime. 
The filter information such as states and enrollment sizes all come from the database of universities that this app pulls information from.

  #### Server side Information

  Once the user has submitted their survey answers to the results view controller, a background thread runs that sends the survey answers to a server database. That way the project members can monitor the survey results and do more research about what high school students as well as parents care about when they look for universities. 
