import SwiftUI

struct MealListView: View {
    @EnvironmentObject private var viewModel: MealListViewModel
    private var coordinator: Coordinator
    
    init(_ coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        TitleView(title: viewModel.title)
            .onAppear() {
                loadItems()
            }
        if viewModel.meals.isEmpty {
            createEmpty(buttonAction: loadItems, isPresented: $viewModel.showAlert)
                .onAppear() { loadItems() }
        } else {
            ScrollView {
                
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(viewModel.meals, id: \.self) { meal in
                        NavigationLink(destination: LazyView(coordinator.goToDetails(id: meal.idMeal))) {
                            ZStack(alignment: .bottom) {
                                createItem(url: meal.strMealThumb, text: meal.strMeal)
                                    .padding(4)
                            }
                        }
                    }
                }
                .padding([.leading, .trailing])
            }
        }
    }
    
    func loadItems() {
        Task {
            await viewModel.fetchList()
        }
    }
}

extension MealListView {
    
    func createItem(url: String, text: String) -> some View {
        let viewModel = ItemComponentViewModel(url: url, text: text)
        let componentView = ItemComponentView(viewModel: viewModel)
        return componentView
    }
    
    func createEmpty(buttonAction: @escaping (() -> ()), isPresented: Binding<Bool>) -> some View {
        let viewModel = EmptyViewModel(buttonAcction: buttonAction, isPresented: isPresented)
        let emptyView = EmptyView(viewModel: viewModel)
        return emptyView
    }
}
