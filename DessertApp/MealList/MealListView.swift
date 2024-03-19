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
        TitleView(title: viewModel.title)
            .onAppear() {
                loadItems()
            }
        if viewModel.meals.isEmpty {
            coordinator.createEmpty(buttonAction: loadItems, isPresented: $viewModel.showAlert)
                .onAppear() { loadItems() }
        } else {
            ScrollView {
                
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(viewModel.meals, id: \.self) { meal in
                        NavigationLink(destination: LazyView(coordinator.goToDetails(id: meal.idMeal))) {
                            ZStack(alignment: .bottom) {
                                coordinator.createItem(url: meal.strMealThumb, text: meal.strMeal)
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
