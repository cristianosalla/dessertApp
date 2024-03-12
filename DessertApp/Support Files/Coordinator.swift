//
//  Coordinator.swift
//  DessertApp
//
//  Created by Cristiano Salla Lunardi on 3/12/24.
//

import Foundation
import SwiftUI

class Coordinator {
    
    init() {
        
    }
    
    func goToCategory() -> some View {
        let viewModel = CategoryViewModel()
        let view = CategoryView(viewModel: viewModel, coordinator: self)
        return view
    }
    
    func goToDetails(id: String) -> some View {
        let viewmodel = DessertDetailsViewModel(id: id)
        let view = DessertDetailsView<DessertDetailsViewModel>(viewmodel, coordinator: self)
        return view
    }
    
    func goToMealList(category: String) -> some View {
        let viewModel = MealListViewModel(category: category)
        let view = DessertListView<MealListViewModel>(viewModel, self)
        return view
    }
    
}
