import SwiftUI

struct TitleView: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.dessertTitle)
            .padding()
    }
}
