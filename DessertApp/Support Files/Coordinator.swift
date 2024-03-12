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
    
    func goToDetails(id: String) -> some View {
        let viewmodel = DessertDetailsViewModel(id: id)
        let view = DessertDetailsView<DessertDetailsViewModel>(viewmodel, coordinator: self)
        return view
    }
    
    func goToDessertList() -> some View {
        let viewModel = DessertListViewModel()
        let view = DessertListView<DessertListViewModel>(viewModel, self)
        return view
    }
    
}
