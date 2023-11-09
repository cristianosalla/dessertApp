# Dessert List


### Screenshots

<img src="https://github.com/cristianosalla/fetchCodeChallenge/blob/main/images/ipadLandscape.png" width=48% height=48%> <img src="https://github.com/cristianosalla/fetchCodeChallenge/blob/main/images/ipadPortrait.png" width=35% height=35%>

<img src="https://github.com/cristianosalla/fetchCodeChallenge/blob/main/images/iphoneList.png" width=32% height=32%> <img src="https://github.com/cristianosalla/fetchCodeChallenge/blob/main/images/iphoneDetail.png" width=32% height=32%> <img src="https://github.com/cristianosalla/fetchCodeChallenge/blob/main/images/iphoneDetail2.png" width=32% height=32%>

### App Data Flow
- The data flow follows the MVVM pattern. The data is requested by the `View` to the `ViewModel`. The View Model uses the `DataProvider` to download the data from the API. The `DataProvider` then sends the `Model` to the `ViewModel` and the data is presented in the `View`.

![alt text](https://github.com/cristianosalla/fetchCodeChallenge/blob/main/images/dataFlowMVVM.png)

### ViewModel
- Responsible to get the data and send to the view. Texts, images and etc.

### View
- Only responsible for showing the elements in the screen. Keep observing for any possible change in the `ViewModel` to update the `View`.

### Model
- Data provided by [The Meal DB](https://themealdb.com/api.php) API.

### Data Provider
- Layer created to communicate with the API. The layer know all the endpoints and is responsible to request the data to the API to set the models. I created two methods for this project. `fetchObject<T: Decodable>` that can download the Details and the List model, depending on the `ViewModel`request. And also I created `fetchImageData`, the method to return image data to create the images in the `View`.

### Loading async images
- Images are being loaded asyncronous in the list. As the user scrolls to the botton and the cell appears, the image of the dessert will load.

<img src="https://github.com/cristianosalla/fetchCodeChallenge/blob/main/images/iphoneLoading.png" width=32% height=32%>

### Handling error
- In case of any error in the API or network, the user will see an alert and an option to try to get the data again.

<img src="https://github.com/cristianosalla/fetchCodeChallenge/blob/main/images/iphoneErrorAlert.png" width=32% height=32%>

### Routing with Navigation Links
- Considering that the application only have 1 route (from the list to the detail). I implemented the Navigation Link that is easy to set in SwiftUI and works well.

### Unit tests
- Implemented unit tests for the `ViewModels` and the `DataProvider`. I consider those two layers the critical part of the app and should be fail-proof.

<img src="https://github.com/cristianosalla/fetchCodeChallenge/blob/main/images/unitTests.png" width=32% height=32%>




