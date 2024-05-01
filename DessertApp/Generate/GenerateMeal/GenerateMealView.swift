import SwiftUI

struct GenerateMealView: View {
    
    @State var meal: Recipe?
    @State private var mealMessage: String = ""
    @State var isPresented = false
    @State var isLoading = false
    
    @EnvironmentObject var viewModel: GenerateMealViewModel
    
    init() { }
        
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    TextField(viewModel.placeholderText, text: $mealMessage)
                        .padding()
                    
                    Text(viewModel.buttonText)
                        .padding()
                        .onTapGesture {
                            buttonTapGesture()
                        }
                        .navigationDestination(isPresented: $isPresented) {
                            LazyView( goTo(meal) )
                        }
                }
                .frame(alignment: .top)
                
                if isLoading {
                    ProgressView()
                }
            }
            .frame(maxWidth: .infinity)
        }
        
    }
    
    func buttonTapGesture() {
        isLoading = true
        Task {
            meal = try await viewModel.getGeneratedMeal(mealMessage)
            isPresented = meal != nil
            isLoading = false
        }
    }
    
    func goTo(_ meal: Recipe?) -> some View {
        let vm = GenerateMealDetailsViewModel(meal: meal)
        let view =  GenerateMealDetailsView(coordinator: Coordinator())
        return view.environmentObject(vm)
    }
    
    func createEmpty(buttonAction: @escaping (() -> ()), isPresented: Binding<Bool>) -> some View {
        let viewModel = EmptyViewModel(buttonAcction: buttonAction, isPresented: isPresented)
        let emptyView = EmptyView(viewModel: viewModel)
        return emptyView
    }
    
}
