import SwiftUI

struct DessertDetailsTextsView: View {
    
    @StateObject var viewModel: DessertDetailsViewModel
    
    var body: some View {
        
        Text(viewModel.ingredientsTitle)
            .font(.dessertTitle2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        ForEach(viewModel.meal?.items ?? [], id: \.self) { obj in
            HStack {
                Text(viewModel.itemFormat(ingredient: obj.ingredient, measure: obj.measure))
                    .font(.dessertText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)
            }
        }
        
        Text(viewModel.instructionsTitle)
            .font(.dessertTitle2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        Text(viewModel.meal?.strInstructions ?? "")
            .font(.dessertText)
            .padding([.leading, .trailing])
        
    }
}
