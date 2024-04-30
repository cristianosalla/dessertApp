import SwiftUI

fileprivate enum Constants {
    static let width: CGFloat = 100
    static let shadowRadius: CGFloat = 3
    static let opacity: CGFloat = 0.7
}

struct PlayButtonView: View {
    
    @ObservedObject var viewModel: PlayButtonViewModel
    
    init(viewModel: PlayButtonViewModel) {
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
