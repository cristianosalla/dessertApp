import SwiftUI

protocol PlayButtonViewModelProtocol: ObservableObject {
    var title: String { get }
    var url: String { get }
    var isPresented: Bool { get set }
    var iconName: String { get }
}

fileprivate enum Constants {
    static let width: CGFloat = 100
    static let shadowRadius: CGFloat = 3
    static let opacity: CGFloat = 0.7
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
                .frame(width: Constants.width, height: Constants.width)
                .foregroundColor(.white)
                .shadow(radius: Constants.shadowRadius)
                .opacity(Constants.opacity)
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
