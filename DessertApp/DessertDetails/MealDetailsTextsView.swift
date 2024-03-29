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

struct CheckBoxView: View {
    
    @State var checked = false
    let lime = Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 0.5))
            .foregroundStyle(.tertiary)
            .frame(width: 30, height: 30, alignment: .center)
            .padding(.leading, 15)
            .onTapGesture { 
                checked.toggle()
            }
            .overlay {
                if checked {
                    Circle()
                        .foregroundColor(lime)
                        .foregroundStyle(.tertiary)
                        .frame(width: 30, height: 30, alignment: .center)
                        .padding(.leading, 15)
                        .onTapGesture {
                            checked.toggle()
                        }
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
            Spacer()
            TimerView()
                .frame(width: 120, height: .infinity, alignment: .bottom)
                .padding()
        }
    }
    
    
    
}
