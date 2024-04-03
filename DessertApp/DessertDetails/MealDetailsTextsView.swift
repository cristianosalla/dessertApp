import SwiftUI

struct MealDetailsTextsView<ViewModel: MealDetailsViewModelProtocol>: View {
    
    @StateObject var viewModel: ViewModel
    
    let color = Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1))
    
    var body: some View {
        
        ScrollView {
            VStack {
                Text(viewModel.ingredientsTitle)
                    .font(.mealTitle2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                IngredientView(viewModel: viewModel)
                
                Button(viewModel.timerButtonText()) {
                    viewModel.showTimer.toggle()
                }
                .frame(alignment: .leading)
                .padding()
                .background(
                    Rectangle()
                        .foregroundColor(color)
                )
                .cornerRadius(5.0)
                .shadow(radius: 3)
                
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

struct IngredientView<ViewModel: MealDetailsViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        Task {
            await viewModel.fetchDetails()
        }
    }

    @State private var isFilled = false

    var body: some View {
        HStack {
            VStack {
                ForEach(viewModel.meal?.items ?? [], id: \.self) { obj in
                    HStack {
                        CheckBoxView()
                        Text(viewModel.itemFormat(ingredient: obj.ingredient, measure: obj.measure))
                            .font(.mealText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                }
            }
        }
    }
    
    
    
}
