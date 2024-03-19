import SwiftUI

protocol PlayButtonViewModelProtocol: ObservableObject {
    var title: String { get }
    var url: String { get }
    var isPresented: Bool { get set }
    var iconName: String { get }
}

struct PlayButtonView<ViewModel: PlayButtonViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        Button(action: {
            viewModel.isPresented = true
        }, label: {
            Image(systemName: viewModel.iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
                .shadow(radius: 3)
                .opacity(0.7)
        }).sheet(isPresented: $viewModel.isPresented) {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    if let url = URL(string: viewModel.url) {
                        WebView(url: url)
                            .ignoresSafeArea()
                            .navigationTitle(viewModel.title)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            } else { }
        }
        
    }
}
