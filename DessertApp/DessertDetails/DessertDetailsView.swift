import SwiftUI

struct DessertDetailsView: View {
    @ObservedObject private var viewModel: DessertDetailsViewModel
    
    init(viewModel: DessertDetailsViewModel) {
        self.viewModel = viewModel
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
            .alert(Text(viewModel.errorAlertText), isPresented: $viewModel.showAlert, actions: {
                Button(viewModel.errorAlertButton) {
                    fetchDetails()
                }
            })
            
        }
        .navigationBarTitle(Text(String()), displayMode: .inline)
    }
    
    var title: String {
        viewModel.meal?.strMeal ?? String()
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
