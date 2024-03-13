import Foundation
import SwiftUI

class Coordinator {
    
    var provider: ObjectProviderProtocol
    
    init(provider: ObjectProviderProtocol = DataProvider()) {
        self.provider = provider
    }
    
    func goToCategory() -> some View {
        let viewModel = CategoryViewModel(dataProvider: provider)
        let view = CategoryView(viewModel: viewModel, coordinator: self)
        return view
    }
    
    func goToDetails(id: String) -> some View {
        let viewmodel = MealDetailsViewModel(id: id, dataProvider: provider)
        let view = MealDetailsView<MealDetailsViewModel>(viewmodel, coordinator: self)
        return view
    }
    
    func goToMealList(category: String) -> some View {
        let viewModel = MealListViewModel(category: category, dataProvider: provider)
        let view = MealListView<MealListViewModel>(viewModel, self)
        return view
    }
    
}
