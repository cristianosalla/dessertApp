import SwiftUI

protocol MealDetailsViewModelProtocol: ObservableObject {
    var title: String { get }
    var instructionsTitle: String { get }
    var ingredientsTitle: String { get }
    var meal: MealDetail? { get }
    var timerButtonText: String { get }
    var showTimer: Bool { get set }
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
        ZStack {
            
            GeometryReader { geometry in
                ScrollView {
                    DetailsTitleView(title: title)
                    
                    ZStack {
                        MealDetailsImageView(width: geometry.size.width, url: detailsURL)
                        if viewModel.showVideo {
                            goToPlayButton(title: viewModel.title, url: viewModel.meal?.strYoutube ?? "")
                        }
                    }
                    
                    MealDetailsTextsView(viewModel: viewModel)
                }.onAppear() {
                    fetchDetails()
                }
            }.navigationBarTitle(Text(String()), displayMode: .inline)
            if viewModel.showTimer {
                Spacer()
                TimerView()
                    .frame(maxHeight: .infinity, alignment: .topTrailing)
                    .shadow(radius: 3)
                    .padding()
                Spacer()
            }
        }
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

extension MealDetailsView {
    func goToPlayButton(title: String, url: String) -> some View {
        let viewModel = PlayButtonViewModel(title: title, url: url)
        let view = PlayButtonView(viewModel: viewModel)
        return view
    }
}
