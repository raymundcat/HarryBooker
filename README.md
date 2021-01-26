## Architecture
The architecture approach used in this app is the same *event-based* coordinator pattern **[Eventful](https://github.com/raymundcat/Eventful)** that I have open sourced as an easy plug-in for any project

 The only screen - **QueryTableViewController** is bound to the view and business layers, namely, **QueryTableView** and **QueryTablePresenter** through Eventful's super classes and templating features.

**QueryTableViewController**
As per design, the view controller becomes the designated navigation layer of the screen, which, for a single screen application, means not much is gonna be expected here other than setting up the other two main components and sending ViewController life cycle events to them

**QueryTablePresenter**
The business layer where all the non-view related decisions are made such as calls to the API layer, mapping of view models, dictating view behaviours that are triggered by external events, etc.

In this project, QueryTablePresenter has two main functions:

 1. Send the view layer information about the query String that is the theme of the app
 2. When informed about the user's pull-to-refresh, fetch the next set of books from the API layer and prepare it for the view layer.

**QueryTableView**
Built with a UITableView utilising a UITableViewDiffableDataSource for a smooth transition of objects knowing that reloading with new content is going to be one of its key features.

[Anchorage](https://github.com/Rightpoint/Anchorage) is my go-to syntax sugar for the layout with really short and concise wrappers for layout constraints. 

Book cover images are loaded straight into the image views using  [SDWebImage](https://github.com/SDWebImage/SDWebImage) 

Other than all the lengthy view setup, this component communicates a pull-to-refresh event to the business layer and listens for updates it can present


## Networking
The networking layer is designed using another open sourced framework of mine, **[EndPoints](https://github.com/raymundcat/EndPoints)** - a lightweight template built to scale API layers smoothly

In this app, only one endpoint needed to be declared, that is https://api.storytel.net/search?query=harry&page=10 which translates to a single **QueryEndPoint** object describing the domain and its other requirements and a single **QueryPath** enum case for describing the request parameters

## Design
A lightweight abstraction of the design elements such as Margins, Colors and Fonts were created to specify the app-specific requirements such as Dark mode support. 

## Testing
Utilising **Eventful** designs, the business layer of the app can easily be tested by mocking the incoming events that trigger its features and capturing the outgoing events produced as a result

API mocks are set smoothly using [OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs/) while [CasePaths](https://github.com/pointfreeco/swift-case-paths) is used to capture enums going out of the presenter layer to make assertions on its expected behaviours.

## Other Libraries

 - [PromiseKit](https://github.com/mxcl/PromiseKit/) - Elegant solution to the long missing promise patterns from Swift. A must-have if you want your code pyramids-free!

