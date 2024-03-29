import SwiftUI

struct MealDetailsTextsView<ViewModel: MealDetailsViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        
        ScrollView {
            VStack {
                Text(viewModel.ingredientsTitle)
                    .font(.mealTitle2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                IngredientTimerView(viewModel: viewModel)
                
                
                Text(viewModel.instructionsTitle)
                    .font(.mealTitle2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                Text(viewModel.meal?.strInstructions ?? String())
                    .font(.mealText)
                    .padding([.leading, .trailing])
            }
        }
        
    }
}

struct IngredientTimerView<ViewModel: MealDetailsViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        Task {
            await viewModel.fetchDetails()
        }
    }


    var body: some View {
        HStack {
            VStack {
                ForEach(viewModel.meal?.items ?? [], id: \.self) { obj in
                    HStack {
                        Text(viewModel.itemFormat(ingredient: obj.ingredient, measure: obj.measure))
                            .font(.mealText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                    }
                }
            }
            TimerView()
                .frame(width: 120, height: 120, alignment: .bottom)
                .padding()
        }
    }
    
    
    
}
