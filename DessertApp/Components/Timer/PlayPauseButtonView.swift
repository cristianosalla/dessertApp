import SwiftUI

struct PlayPauseButtonView: View {
    
    enum Constants {
        static let buttonWidth: CGFloat = 30
        static let shadowRadius: CGFloat = 3
    }
    
    enum Strings {
        static let stopIcon = "stop.circle.fill"
        static let playIcon = "play.circle.fill"
        static let matchedId = "icon"
    }
    
    @Binding var isRunning: Bool
    var action: (() -> ())

    @Namespace var namespace
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: isRunning ?  Strings.stopIcon : Strings.playIcon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: Constants.buttonWidth, height: Constants.buttonWidth)
                .foregroundColor(.white)
                .shadow(radius: Constants.shadowRadius)
                .matchedGeometryEffect(id: Strings.matchedId, in: namespace)
        })
    }
}
