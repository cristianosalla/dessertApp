//
//  DessertDetails.swift
//  FetchCodeChallenge
//
//  Created by Cristiano Salla Lunardi on 11/1/23.
//

import SwiftUI

struct DessertDetailsView: View {
    @StateObject private var viewModel = DessertDetailsViewModel()
    
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                TitleView(title: viewModel.meal?.strMeal ?? "")
                
                DessertDetailsImageView(width: geometry.size.width, url: URL(string: viewModel.meal?.strMealThumb ?? ""))
                
                DessertDetailsTextsView(viewModel: viewModel)
            }
            .onAppear() {
                viewModel.fetchDetails(id: id)
            }
            .alert(Text(viewModel.errorAlertText), isPresented: $viewModel.showAlert, actions: {
                Button(viewModel.errorAlertButton) {
                    viewModel.fetchDetails(id: id)
                }
            })
            
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
    }
    
}
