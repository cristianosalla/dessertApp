import SwiftUI

fileprivate enum Constants {
    static let buttonWidth: CGFloat = 30
    static let shadowRadius: CGFloat = 3
}

fileprivate enum Strings {
    static let stopIcon = "stop.circle.fill"
    static let playIcon = "play.circle.fill"
    static let matchedId = "icon"
}

struct PlayPauseButtonView<ViewModel: TimerViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    @Namespace var namespace
    
    var body: some View {
        Button(action: {
            viewModel.buttonActon()
        }, label: {
            Image(systemName: viewModel.isRunning ?  Strings.stopIcon : Strings.playIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.buttonWidth, height: Constants.buttonWidth)
                .foregroundColor(.white)
                .shadow(radius: Constants.shadowRadius)
                .matchedGeometryEffect(id: Strings.matchedId, in: namespace)
        })
    }
}
