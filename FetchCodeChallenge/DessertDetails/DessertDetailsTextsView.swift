//
//  DessertDetailsTexts.swift
//  FetchCodeChallenge
//
//  Created by Cristiano Salla Lunardi on 11/2/23.
//

import SwiftUI

struct DessertDetailsTextsView: View {
    
    @StateObject var viewModel: DessertDetailsViewModel
    
    var body: some View {
        
        Text(viewModel.ingredientsTitle)
            .font(.dessertTitle2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        ForEach(viewModel.ingredientsAndMeasures, id: \.self) { obj in
            HStack {
                Text(viewModel.ingredientMeasureFormat(ingredient: obj.ingredient, measure: obj.measure))
                    .font(.dessertText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)
            }
        }
        
        Text(viewModel.instructionsTitle)
            .font(.dessertTitle2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        Text(viewModel.instructions)
            .font(.dessertText)
            .padding([.leading, .trailing])
        
    }
}
