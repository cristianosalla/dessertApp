//
//  CategoryView.swift
//  DessertApp
//
//  Created by Cristiano Salla Lunardi on 3/12/24.
//

import Foundation
import SwiftUI


protocol CategoryViewModelProtocol: ObservableObject {
    var categories: [Categories] { get }
    var showAlert: Bool { get set }
    var alertText: String { get }
    var alertButton: String { get }
    var title: String { get }
    func fetchList() async
}

struct CategoryView<ViewModel: CategoryViewModelProtocol>:  View {
    
    @ObservedObject private var viewModel: ViewModel
    private var coordinator: Coordinator
    init(viewModel: ViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    
    var body: some View {
        if viewModel.categories.isEmpty {
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
                        ForEach(viewModel.categories, id: \.self) { category in
                            NavigationLink(destination: coordinator.goToMealList(category: category.strCategory)) {
                                ZStack(alignment: .bottom) {
                                    let viewModel = ItemComponentViewModel(url: category.strCategoryThumb, text: category.strCategory)
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
    }
    
    
    func loadItems() {
        Task {
            await viewModel.fetchList()
        }
    }
}
