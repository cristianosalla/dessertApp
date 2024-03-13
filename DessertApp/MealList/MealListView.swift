import SwiftUI

protocol MealListViewModelProtocol: ObservableObject {
    var title: String { get }
    var meals: [Meal] { get set }
    var showAlert: Bool { get set }
    func fetchList() async
}

struct MealListView<ViewModel: MealListViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel
    private var coordinator: Coordinator
    
    init(_ viewModel: ViewModel, _ coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        if viewModel.meals.isEmpty {
            EmptyView(buttonAction: loadItems, isPresented: $viewModel.showAlert)
        } else {
            ScrollView {
                TitleView(title: viewModel.title)
                
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(viewModel.meals, id: \.self) { meal in
                        NavigationLink(destination: coordinator.goToDetails(id: meal.idMeal)) {
                            ZStack(alignment: .bottom) {
                                let viewModel = ItemComponentViewModel(url: meal.strMealThumb, text: meal.strMeal)
                                let componentView = ItemComponentView(viewModel: viewModel)
                                componentView
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
