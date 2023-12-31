import SwiftUI

struct DessertListView: View {
    @StateObject private var viewModel = DessertListViewModel()
    
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
                            NavigationLink(destination: DessertDetailsView(viewModel: DessertDetailsViewModel(id: meal.idMeal))) {
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
