import Foundation
import SwiftUI

class Coordinator {
    
    var objectProvider: ObjectProviderProtocol
    var imageProvider: ImageProviderProtocol
    
    init(objectProvider: ObjectProviderProtocol? = nil, imageProvider: ImageProviderProtocol? = nil) {
        if let objectProvider {
            self.objectProvider = objectProvider
        } else {
            self.objectProvider = DataProvider()
        }
        
        if let imageProvider {
            self.imageProvider = imageProvider
        } else {
            self.imageProvider = DataProvider()
        }
    }
    
    func goToCategory() -> some View {
        let viewModel = CategoryViewModel(dataProvider: objectProvider)
        let view = CategoryView(viewModel: viewModel, coordinator: self)
        return view
    }
    
    func goToDetails(id: String) -> some View {
        let viewmodel = MealDetailsViewModel(id: id, dataProvider: objectProvider)
        let view = MealDetailsView<MealDetailsViewModel>(viewmodel, coordinator: self)
        return view
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
    
    func goToPlayButton(title: String, url: String) -> some View {
        let viewModel = PlayButtonViewModel(title: title, url: url)
        let view = PlayButtonView(viewModel: viewModel)
        return view
    }
    
    func createItem(url: String, text: String) -> some View {
        let viewModel = ItemComponentViewModel(url: url, text: text, dataProvider: imageProvider)
        let componentView = ItemComponentView(viewModel: viewModel)
        return componentView
    }
    
    func createEmpty(buttonAction: @escaping (() -> ()), isPresented: Binding<Bool>) -> some View {
        let viewModel = EmptyViewModel(buttonAcction: buttonAction, isPresented: isPresented)
        let emptyView = EmptyView(viewModel: viewModel)
        return emptyView
    }
    
    
    
}
