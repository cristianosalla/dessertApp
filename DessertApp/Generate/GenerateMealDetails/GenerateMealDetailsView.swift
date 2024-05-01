import SwiftUI

struct GenerateMealDetailsView: View {
    @EnvironmentObject var viewModel: GenerateMealDetailsViewModel
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
                    GenerateMealDetailsTextsView()
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
    
    func timerView() -> some View {
        let viewModel = TimerViewModel()
        let view = TimerView()
        return view.environmentObject(viewModel)
    }
}
