//
//  ItemComponentView.swift
//  DessertApp
//
//  Created by Cristiano Salla Lunardi on 3/12/24.
//

import SwiftUI

protocol ItemComponentViewModelProtocol: ObservableObject {
    var url: String { get }
    var text: String { get }
    func getThumb() async throws -> Data
}

struct ItemComponentView<ViewModel: ItemComponentViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel

    @State var image: UIImage?
    
    init(viewModel: ViewModel) {
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
            getImage()
        }
        
        Text(viewModel.text)
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
    
    func getImage() {
        if image == nil {
            Task {
                let data = try await viewModel.getThumb()
                if let image = UIImage(data: data) {
                    self.image = image
                }
            }
        }
    }
}
