//
//  TitleView.swift
//  FetchCodeChallenge
//
//  Created by Cristiano Salla Lunardi on 11/6/23.
//

import SwiftUI

struct TitleView: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.dessertTitle)
            .padding()
    }
}
