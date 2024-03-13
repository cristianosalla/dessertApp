import SwiftUI

protocol MealDetailsViewModelProtocol: ObservableObject {
    var title: String { get }
    var instructionsTitle: String { get }
    var ingredientsTitle: String { get }
    var showAlert: Bool { get set }
    var meal: MealDetail? { get }
    func fetchDetails() async
    func itemFormat(ingredient: String, measure: String) -> String
}

struct MealDetailsView<ViewModel: MealDetailsViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel
    private var coordinator: Coordinator
    
    init(_ viewModel: ViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                TitleView(title: title)
                
                MealDetailsImageView(width: geometry.size.width, url: detailsURL)
                
                MealDetailsTextsView(viewModel: viewModel)
            }.onAppear() {
                fetchDetails()
            }
        }.navigationBarTitle(Text(String()), displayMode: .inline)
    }
    
    var title: String {
        viewModel.title
    }
    
    var detailsURL: URL? {
        URL(string: viewModel.meal?.strMealThumb ?? String())
    }
    
    func fetchDetails() {
        Task {
            await viewModel.fetchDetails()
        }
    } 
}
