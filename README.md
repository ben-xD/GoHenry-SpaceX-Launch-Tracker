# :dizzy: :alien: :rocket: space_time :dizzy: :alien: :rocket:

SpaceX rocket launch times viewer by Ben Butterworth. Done in 2 days: 14th and 15th March, 2021.

### My solution
- I found that the SpaceX Upcoming Launches API gave launch dates to varying precision (accurate to 1 month, accurate to 1 year, etc), so I handled date precision: some dates are "relative" (e.g. in a day) when they are more precise, but others are months/ years (e.g. May) when they are less precise. 
- I initially implemented the header (`Launch`, `date/ UTC`), but realized the content speaks for itself once the dates are provided in a human friendly format.
- I don't use `const Widget` because I have not found a performance benchmark for it, have you? It will likely increase memory usage but improve speed for AOT builds. (though most likely these effects are negligible).

### Word of warning

They've shown that they want to see very strong *"separation of concerns"*, e.g. 

- separate models separate from DTO
- Repository classes, not just Service classes
- If you using Navigator 2.0, refactor that into its own Widget.

That means the project would be highly fragmented, which might be uncomfortable for some people.

### Some screenshots

See `/images/ios` and `images/android` for more images.

<img src="images/android/skeleton.png" alt="Skeleton" width="200"/>

<img src="images/ios/countdown-landscape.png" alt="Landscape coutdown" width="400"/>

<img src="images/android/sharing.png" alt="Sharing" width="200"/>

<img src="images/ios/countdown.png" alt="Landscape" width="200"/>

<img src="images/ios/launches.png" alt="launches" width="200"/>

### I discovered an inconsistency between iOS and Android:

Notice there is a gap between `06` and `DAYS` on iOS, but not Android. This is because the text baselines are inconsistent. See [16257](https://github.com/flutter/flutter/issues/16257) for more information.

<img src="images/baseline_error.png" alt="Baseline error" width="400"/>

### Resources & licenses

- Digital-7 font used for countdown was taken from https://www.dafont.com/digital-7.font - free for personal use

### Oops
There are no tests. I got too engrossed in trying out different flutter features. Perhaps my private repo https://github.com/ben-xD/SpaceTime will have the tests? :sparkles: :poop:

# GoHenry Test Readme

### Objective

Your assignment is to create an app showcasing and notifying visitors about
the next SpaceX rocket launch, and displaying details about next launches.
Use Dart and Flutter.

### Brief

You're the last app developer on earth. Everyone is leaving and going to Mars,
to live a safer, cooler life there. The one problem is, people need to know when the next launch
is happening, and that's where you come in the picture. You need to build an app that informs
the public about the next launch, and give them information about future launches.
Everyone is counting on you, go create that app.

### Tasks

- Implement assignment using:
  - Language: **Dart**
  - Framework: **Flutter**
- Build out the project to the designs inside the `/Designs` folder (They look similar to my screenshots, but I don't have the 2 original screenshots)
- Connect your application to the **SpaceX-API** (Docs and playground: `https://docs.spacexdata.com/?version=latest`)
- Use the API to build two screens/sections like in the design
- The countdown should be live and specify days, hours, minutes and seconds
- The 'Upcoming Launches' screen/section should display the mission name and date, like in the design
- The countdown and upcoming launches table can be implemented either in separate screens (implement navigation), make them intuitive and fluid
- Add a share buttons for social media platforms, to share the next launch with friends
- Fetching should be done safely, with a fallback when an error occurs
- Each launch should have a 'Bookmark' or 'Favourite' button, that adds it to a separate 'Favourites'
  table/screen. Implement using local storage (either save the launches data or its id for
  later fetching)

### API Endpoints

- Next Launch Counter: 'https://api.spacexdata.com/v4/launches/next'
- Upcoming Launches: 'https://api.spacexdata.com/v4/launches/upcoming'

With these endpoints, a simple GET request will provide you all the data needed for the tasks, no authentication required.

### Deliverables

Make sure to include all source code in the repository. To make reviewing easier, include a fully built version of your assignment in a folder named **public**.

### Evaluation Criteria

- **Dart** best practices
- MVC or MVVM design patterns
- Efficient use of packages to speed up development
- Show us your work through your commit history
- Completeness: did you complete the features?
- Correctness: does the functionality act in sensible, thought-out ways?
- Maintainability: is it written in a clean, maintainable way?
- Testing: is the system adequately tested? do your components have unit tests?
- Responsiveness and full iOS/Android compatibility
- Elegantly use placeholders/skeletons when fetching data

### CodeSubmit

Please organise, design, test and document your code as if it were
going into production - then push your changes to the master branch. After you have pushed your code, you may submit the assignment on the assignment page.

All the best and happy coding,

The gohenry Ltd. Team

# Feedback from GoHenry

> Your project did everything we wanted it to, but there were some aspects of the code we felt could be improved. The main issue was that there wasn’t a clear separation of concerns, a few examples; DTO and Model in the same class, the launch service having mixed responsibilities (shared prefs/retrieving launches) and the navigator being in the upcoming launches. We would have also liked to have seen some tests, but understand the time constraints may have played a factor here.
>
> This was by no means a bad test and we felt you made a good attempt at it, but ultimately the team felt that other candidate's solutions matched slightly more closely with what we were hoping for.

## My evaluation of the feedback

Separation of concerns only brings benefits when the code requires it. Granted, I did not write tests so there was less need for it, but the first port of call to add testability is better dependency injection, not class decomposition. Conversely, people went from MVC to MVVM, not because they wanted separation of concerns, but because **classes got too big** (to test and to read). None of my classes are big, and it seems like the engineer who reviewed my code is using SoC as rule (dogma). Code can get refactored when needed, and using a DTO for this project may cost more time and complexity than its worth.

- Please see the Spacex-go project by Jesus (with 554 stars on GithubE.g. He doesn’t use DTOs, look at his model, and his project is much more complicated: https://github.com/jesusrp98/spacex-go/blob/master/lib/models/launch_details.dart
- He uses Navigator 1.0 which is imperative (rather than declarative) and so navigation code is **littered all over the code base**, I can’t believe putting **Navigator 2.0** in UpcomingLaunches is a sticking point here. Logically, this navigator is used only for the UpcomingLaunches screen, as opposed to other future screens such as Settings, login, and any other functionality. This is much cleaner than what other applicants would have done. 
- The LaunchService holds responsibility for all launch related matters. Shared preferences and network requests are abstracted within that, making my module deeper, and therefore simpler for users of LaunchService. Sure, I could have abstracted shared preferences access and network requests to separate repository classes, but the class was small enough, it didn’t ask for it.