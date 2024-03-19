import SwiftUI

protocol EmptyViewModelProtocol: ObservableObject {
    var alertText: String { get }
    var alertButton: String { get }
    var isPresented: Binding<Bool> { get }
    var buttonAcction: (() -> ()) { get }
}

struct EmptyView<ViewModel: EmptyViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ProgressView()
            .alert(Text(viewModel.alertText), isPresented: viewModel.isPresented, actions: {
                Button(viewModel.alertButton) {
                    viewModel.buttonAcction()
                }
            })
    }
    
}
