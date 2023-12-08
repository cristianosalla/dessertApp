import SwiftUI

struct DessertListItemView: View {
    @ObservedObject var viewModel: DessertListItemViewModel

    @State var image: UIImage?
    
    init(viewModel: DessertListItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            if let image = self.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.gray)
                    ProgressView()
                }
            }
        }
        .aspectRatio(contentMode: .fill)
        .frame(maxWidth: 300, maxHeight: 300)
        .cornerRadius(8)
        .shadow(color: .gray, radius: 4, x: 0, y: 4)
        .onAppear {
            if image == nil {
                viewModel.getThumb { data in
                    if let data,
                        let image = UIImage(data: data) {
                        self.image = image
                    }
                }
            }
        }
        
        Text(viewModel.meal)
            .lineLimit(1)
            .font(.dessertText)
            .foregroundColor(Color.white)
            .background(
                Rectangle()
                    .foregroundColor(Color.black)
                    .blur(radius: 5)
            )
            .padding([.leading, .trailing, .bottom], 5)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
