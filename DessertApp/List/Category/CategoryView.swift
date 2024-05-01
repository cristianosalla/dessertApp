import Foundation
import SwiftUI
import Combine

struct CategoryView:  View {
    
    @EnvironmentObject private var viewModel: CategoryViewModel
    private var coordinator: Coordinator
    
    @State private var searchText = ""
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    var body: some View {
        if viewModel.categories.isEmpty {
            createEmpty(buttonAction: loadItems, isPresented: $viewModel.showAlert)
                .onAppear() { loadItems() }
        } else {
            NavigationStack {
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
                        createItem(url: category.strCategoryThumb, text: category.strCategory)
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

extension CategoryView {
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
