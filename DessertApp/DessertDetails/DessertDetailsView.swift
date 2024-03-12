import SwiftUI

protocol DessertDetailsViewModelProtocol: ObservableObject {
    var alertText: String { get }
    var alertButton: String { get }
    var title: String { get }
    var instructionsTitle: String { get }
    var ingredientsTitle: String { get }
    var showAlert: Bool { get set }
    var meal: MealDetail? { get }
    func fetchDetails() async
    func itemFormat(ingredient: String, measure: String) -> String
}

struct DessertDetailsView<ViewModel: DessertDetailsViewModelProtocol>: View {
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
                
                DessertDetailsImageView(width: geometry.size.width, url: detailsURL)
                
                DessertDetailsTextsView(viewModel: viewModel)
            }
            .onAppear() {
                fetchDetails()
            }
            .alert(Text(viewModel.alertText), isPresented: $viewModel.showAlert, actions: {
                Button(viewModel.alertButton) {
                    fetchDetails()
                }
            })
            
        }
        .navigationBarTitle(Text(String()), displayMode: .inline)
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
