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
        let view = CategoryView(viewModel: viewModel, coordinator: self)
        return view
    }
    
    func goToDetails(id: String) -> some View {
        let viewmodel = MealDetailsViewModel(id: id, dataProvider: objectProvider)
        let view = MealDetailsView(coordinator: self)
        return view.environmentObject(viewmodel)
    }
    
    func goToMealList(category: String) -> some View {
        let viewModel = MealListViewModel(category: category, dataProvider: objectProvider)
        let view = MealListView<MealListViewModel>(viewModel, self)
        return view
    }
    
    func goToSearchList() -> some View {
        let viewModel = SearchViewModel(dataProvider: objectProvider)
        let view = SearchView<SearchViewModel>(viewModel, self)
        return view
    }
    
    func goToTabBarView() -> some View {
        let view = TabBarView(coordinator: self)
        return view
    }
    
}
