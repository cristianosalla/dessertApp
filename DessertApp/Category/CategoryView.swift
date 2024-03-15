import Foundation
import SwiftUI

protocol CategoryViewModelProtocol: ObservableObject {
    var categories: [Categories] { get }
    var searchedMeals: [Meal] { get }
    var showAlert: Bool { get set }
    var title: String { get }
    var searchText: String { get set }
    func fetchList() async
}

struct CategoryView<ViewModel: CategoryViewModelProtocol>:  View {
    
    @ObservedObject private var viewModel: ViewModel
    private var coordinator: Coordinator
    
    @State private var searchText = ""
    
    init(viewModel: ViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        if viewModel.categories.isEmpty {
            EmptyView(buttonAction: loadItems, isPresented: $viewModel.showAlert).onAppear() {
                loadItems()
            }
        } else {
            NavigationView {
                VStack {
                    TitleView(title: viewModel.title)
                    
                    TextField("Search: ", text: $viewModel.searchText)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                        
                    ScrollView {
                            
                        if viewModel.searchedMeals.isEmpty {
                            list()
                                .padding([.leading, .trailing])
                        } else {
                            searchList()
                                .padding([.leading, .trailing])
                        }
                    }
                }
            }
        }
    }
    
    func list() -> some View {
        let view = LazyVGrid(columns: [GridItem()]) {
            ForEach(viewModel.categories, id: \.self) { category in
                NavigationLink(destination: LazyView( coordinator.goToMealList(category: category.strCategory))) {
                    ZStack(alignment: .bottom) {
                        coordinator.createItem(url: category.strCategoryThumb, text: category.strCategory)
                            .padding(4)
                    }
                }
            }
        }
        return view
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
    
//    TODO: fix CI to accept iOS 17.0
//    @available(iOS 17.0, *)
//    func listWithTransition() -> some View {
//        let view = ForEach(viewModel.categories, id: \.self) { category in
//            NavigationLink(destination: LazyView( coordinator.goToMealList(category: category.strCategory))) {
//                ZStack(alignment: .bottom) {
//                    coordinator.createItem(url: category.strCategoryThumb, text: category.strCategory)
//                        .padding(4)
//                }
//            }
//        }.scrollTransition(.animated.threshold(.visible(0.9))) { content, phase in
//            content
//                .opacity(phase.isIdentity ? 1 : 0)
//                .scaleEffect(phase.isIdentity ? 1 : 0.75)
//                .blur(radius: phase.isIdentity ? 0 : 10)
//        }
//        return view
//    }
    
    func loadItems() {
        Task {
            await viewModel.fetchList()
        }
    }
}
