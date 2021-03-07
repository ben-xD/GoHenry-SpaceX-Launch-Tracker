# space_time

SpaceX rocket launch times viewer

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
- Build out the project to the designs inside the `/Designs` folder
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