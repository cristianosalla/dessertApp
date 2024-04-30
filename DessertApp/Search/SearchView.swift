import Foundation
import SwiftUI

struct SearchView:  View {
    
    @EnvironmentObject var viewModel: SearchViewModel
    private var coordinator: Coordinator
    
    @State private var searchText = String()
    
    init(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        NavigationStack {
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
    
    
}

extension SearchView {
    func searchList() -> some View {
        LazyVGrid(columns: [GridItem(), GridItem()]) {
            ForEach(viewModel.searchedMeals, id: \.self) { meal in
                NavigationLink(destination: LazyView(coordinator.goToDetails(id: meal.idMeal))) {
                    ZStack(alignment: .bottom) {
                        createItem(url: meal.strMealThumb, text: meal.strMeal)
                            .padding(4)
                    }
                }
            }
        }
    }
    
    func createItem(url: String, text: String) -> some View {
        let viewModel = ItemComponentViewModel(url: url, text: text)
        let componentView = ItemComponentView(viewModel: viewModel)
        return componentView
    }
}
