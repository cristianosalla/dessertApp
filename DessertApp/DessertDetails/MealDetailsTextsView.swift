import SwiftUI

struct MealDetailsTextsView<ViewModel: MealDetailsViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        
        Text(viewModel.ingredientsTitle)
            .font(.mealTitle2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        ForEach(viewModel.meal?.items ?? [], id: \.self) { obj in
            HStack {
                Text(viewModel.itemFormat(ingredient: obj.ingredient, measure: obj.measure))
                    .font(.mealText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 15)
            }
        }
        
        Text(viewModel.instructionsTitle)
            .font(.mealTitle2)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        
        Text(viewModel.meal?.strInstructions ?? String())
            .font(.mealText)
            .padding([.leading, .trailing])
        
    }
}
