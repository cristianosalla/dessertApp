import Foundation
import SwiftUI

protocol SearchViewModelProtocol: ObservableObject {
    var title: String { get }
    var searchText: String { get set }
    var searchedMeals: [Meal] { get }
}

struct SearchView<ViewModel: SearchViewModelProtocol>:  View {
    
    @ObservedObject private var viewModel: ViewModel
    private var coordinator: Coordinator
    
    @State private var searchText = ""
    
    init(_ viewModel: ViewModel, _ coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TitleView(title: viewModel.title)
                
                TextField(String(), text: $viewModel.searchText)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                ScrollView {
                    searchList()
                }
            }
        }
    }
    
    func searchList() -> some View {
        LazyVGrid(columns: [GridItem(), GridItem()]) {
            ForEach(viewModel.searchedMeals, id: \.self) { meal in
                NavigationLink(destination: LazyView(coordinator.goToDetails(id: meal.idMeal))) {
                    ZStack(alignment: .bottom) {
                        coordinator.createItem(url: meal.strMealThumb, text: meal.strMeal)
                            .padding(4)
                    }
                }
            }
        }
    }
}
