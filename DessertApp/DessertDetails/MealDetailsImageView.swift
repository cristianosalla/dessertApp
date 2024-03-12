import SwiftUI

struct MealDetailsImageView: View {
    var width: CGFloat
    var url: URL?
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .cornerRadius(10)
                .shadow(radius: 5)
                .padding()
        } placeholder: {
            ProgressView()
        }
        .frame(width: self.width, height: self.width)
    }
}

