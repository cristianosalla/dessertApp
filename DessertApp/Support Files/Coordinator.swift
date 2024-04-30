import Foundation
import SwiftUI

class Coordinator {
    
    var objectProvider: ObjectProviderProtocol
    var imageProvider: ImageProviderProtocol
    
    init(objectProvider: ObjectProviderProtocol? = nil,
         imageProvider: ImageProviderProtocol? = nil) {
        self.objectProvider = objectProvider ?? DataProvider()
        self.imageProvider = imageProvider ?? DataProvider()
    }
    
    func goToCategory() -> some View {
        let viewModel = CategoryViewModel(dataProvider: objectProvider)
        let view = CategoryView(coordinator: self)
        return view.environmentObject(viewModel)
    }
    
    func goToDetails(id: String) -> some View {
        let viewModel = MealDetailsViewModel(id: id, dataProvider: objectProvider)
        let view = MealDetailsView(coordinator: self)
        return view.environmentObject(viewModel)
    }
    
    func goToMealList(category: String) -> some View {
        let viewModel = MealListViewModel(category: category, dataProvider: objectProvider)
        let view = MealListView(self)
        return view.environmentObject(viewModel)
    }
    
    func goToSearchList() -> some View {
        let viewModel = SearchViewModel(dataProvider: objectProvider)
        let view = SearchView(self)
        return view.environmentObject(viewModel)
    }
    
    func goToTabBarView() -> some View {
        let view = TabBarView(coordinator: self)
        return view
    }
    
}
