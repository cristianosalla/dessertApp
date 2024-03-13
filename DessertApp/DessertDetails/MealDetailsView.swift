import SwiftUI

protocol MealDetailsViewModelProtocol: ObservableObject {
    var title: String { get }
    var instructionsTitle: String { get }
    var ingredientsTitle: String { get }
    var meal: MealDetail? { get }
    var showVideo: Bool { get }
    func fetchDetails() async
    func itemFormat(ingredient: String, measure: String) -> String
}

struct MealDetailsView<ViewModel: MealDetailsViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel
    private var coordinator: Coordinator
    
    @State private var isPresentWebView = false
    
    init(_ viewModel: ViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                TitleView(title: title)
                
                ZStack {
                    MealDetailsImageView(width: geometry.size.width, url: detailsURL)
                    if viewModel.showVideo {
                        PlayButtonView(title: viewModel.title, url: viewModel.meal?.strYoutube)
                    }
                }
                
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
