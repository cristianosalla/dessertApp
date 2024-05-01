import SwiftUI

struct GenerateMealDetailsTextsView: View {
    
    @EnvironmentObject var viewModel: GenerateMealDetailsViewModel
    
    let color = Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1))
    
    var body: some View {
        
        ScrollView {
            VStack {
                Text(viewModel.ingredientsTitle)
                    .font(.mealTitle2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                GenerateMealIngredientView(viewModel: viewModel)
                
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
                
                
                ForEach(viewModel.meal?.instructions ?? [], id: \.self) { obj in
                    Text(obj)
                        .font(.mealText)
                        .padding([.leading, .trailing])
                }
                
            }
        }
        
    }
}

struct GenerateMealIngredientView: View {
    
    @ObservedObject var viewModel: GenerateMealDetailsViewModel
    
    @State private var isFilled = false

    var body: some View {
        HStack {
            VStack {
                ForEach(viewModel.meal?.ingredients ?? [], id: \.self) { obj in
                    HStack {
                        CheckBoxView()
                        Text(viewModel.itemFormat(ingredient: obj, measure: ""))
                            .font(.mealText)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                    }
                }
            }
        }
    }
}
