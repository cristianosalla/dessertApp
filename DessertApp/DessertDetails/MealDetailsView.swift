import SwiftUI

struct MealDetailsView: View {
    @EnvironmentObject private var viewModel: MealDetailsViewModel
    
    private var coordinator: Coordinator
    
    @State private var isPresentWebView = false
    
    init(coordinator: Coordinator) {
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
                    
                    MealDetailsTextsView()
                }.onAppear() {
                    fetchDetails()
                }
            }.navigationBarTitle(Text(String()), displayMode: .inline)
            if viewModel.showTimer {
                Spacer()
                timerView()
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
    
    func timerView() -> some View {
        let viewModel = TimerViewModel()
        let view = TimerView()
        return view.environmentObject(viewModel)
    }
}

extension MealDetailsView {
    func goToPlayButton(title: String, url: String) -> some View {
        let viewModel = PlayButtonViewModel(title: title, url: url)
        let view = PlayButtonView(viewModel: viewModel)
        return view
    }
}
