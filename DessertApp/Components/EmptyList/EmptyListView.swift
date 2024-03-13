import SwiftUI

struct EmptyListView: View {
    
    @ObservedObject var viewModel: EmptyListViewModel
    
    init(buttonAction: @escaping (() -> Void), isPresented: Binding<Bool>) {
        let viewModel = EmptyListViewModel(buttonAcction: buttonAction, isPresented: isPresented)
        self.viewModel = viewModel
    }
    
    var body: some View {
        ProgressView()
            .alert(Text(viewModel.alertText), isPresented: viewModel.isPresented, actions: {
                Button(viewModel.alertButton) {
                    viewModel.buttonAcction()
                }
            }).onAppear() {
                viewModel.buttonAcction()
            }
    }
    
}
