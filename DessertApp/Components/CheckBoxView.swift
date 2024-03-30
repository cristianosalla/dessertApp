import SwiftUI

struct CheckBoxView: View {
    enum Constants {
        static let width: CGFloat = 30.0
        static let lineWidth: CGFloat = 0.5
        static let leading: CGFloat = 15
        static let circleOpacity: CGFloat = 0.1
    }
    
    let fill = Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    @State var checked = false
    
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: Constants.lineWidth))
            .background(Circle().foregroundColor( checked ? fill : .white.opacity(Constants.circleOpacity)))
            .foregroundStyle(.tertiary)
            .frame(width: Constants.width, height: Constants.width, alignment: .center)
            .padding(.leading, Constants.leading)
            .onTapGesture { checked.toggle() }
    }
    
}
