import Foundation
import SwiftUI

class Coordinator {
    
    func goToCategory() -> some View {
        let viewModel = CategoryViewModel()
        let view = CategoryView(viewModel: viewModel, coordinator: self)
        return view
    }
    
    func goToDetails(id: String) -> some View {
        let viewmodel = MealDetailsViewModel(id: id)
        let view = MealDetailsView<MealDetailsViewModel>(viewmodel, coordinator: self)
        return view
    }
    
    func goToMealList(category: String) -> some View {
        let viewModel = MealListViewModel(category: category)
        let view = MealListView<MealListViewModel>(viewModel, self)
        return view
    }
    
}
