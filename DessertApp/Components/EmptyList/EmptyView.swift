import SwiftUI

struct EmptyView: View {
    
    @ObservedObject var viewModel: EmptyViewModel
    
    init(buttonAction: @escaping (() -> Void), isPresented: Binding<Bool>) {
        let viewModel = EmptyViewModel(buttonAcction: buttonAction, isPresented: isPresented)
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
