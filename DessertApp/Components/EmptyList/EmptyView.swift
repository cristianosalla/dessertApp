import SwiftUI

struct EmptyView: View {
    
    @ObservedObject var viewModel: EmptyViewModel
    
    init(viewModel: EmptyViewModel) {
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
