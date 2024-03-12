import SwiftUI

protocol DessertListViewModelProtocol: ObservableObject {
    var alertText: String { get }
    var alertButton: String { get }
    var title: String { get }
    var meals: [Meal] { get set }
    var showAlert: Bool { get set }
    func fetchList() async
}

struct DessertListView<ViewModel: DessertListViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel
    private var coordinator: Coordinator
    
    init(_ viewModel: ViewModel, _ coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        if viewModel.meals.isEmpty {
            ProgressView()
                .alert(Text(viewModel.alertText), isPresented: $viewModel.showAlert, actions: {
                    Button(viewModel.alertButton) {
                        loadItems()
                    }
                }).onAppear() {
                    loadItems()
                }
        } else {
            NavigationView {
                ScrollView {
                    TitleView(title: viewModel.title)
                    
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(viewModel.meals, id: \.self) { meal in
                            NavigationLink(destination: coordinator.goToDetails(id: meal.idMeal)) {
                                ZStack(alignment: .bottom) {
                                    DessertListItemView(viewModel: DessertListItemViewModel(url: meal.strMealThumb, meal: meal.strMeal))
                                        .padding(4)
                                }
                            }
                        }
                    }
                    .padding([.leading, .trailing])
                }
            }
            .accentColor(.black)
        }
    }
    
    func loadItems() {
        Task {
            await viewModel.fetchList()
        }
    }
}
