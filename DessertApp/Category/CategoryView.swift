import Foundation
import SwiftUI
import Combine

protocol CategoryViewModelProtocol: ObservableObject {
    var categories: [Categories] { get }
    var showAlert: Bool { get set }
    var title: String { get }
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
            coordinator.createEmpty(buttonAction: loadItems, isPresented: $viewModel.showAlert)
                .onAppear() { loadItems() }
        } else {
            NavigationView {
                VStack {
                    TitleView(title: viewModel.title)
                        
                    ScrollView {
                        list()
                            .padding([.leading, .trailing])
                        
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
