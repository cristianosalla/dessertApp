//
//  DessertDetailsImage.swift
//  FetchCodeChallenge
//
//  Created by Cristiano Salla Lunardi on 11/2/23.
//

import SwiftUI

struct DessertDetailsImageView: View {
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

