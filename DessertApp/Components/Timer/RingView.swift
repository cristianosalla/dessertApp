import SwiftUI

struct RingView<ViewModel: TimerViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
        
    let width: CGFloat
    let radius: CGFloat
    let sliderWidth: CGFloat
    
    init(viewModel: ViewModel, width: CGFloat) {
        self.viewModel = viewModel

        self.width = width
        self.radius = (width/2.0) * 0.9
        self.sliderWidth = width * 0.1
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: sliderWidth))
                .foregroundStyle(.tertiary)
                .frame(width: radius * 2.0, height: radius * 2.0, alignment: .center)
                .overlay {
                    if viewModel.isRunning {
                        RingAnimationView(viewModel: viewModel, sliderWidth: sliderWidth)
                    } else {
                        PickerTimeView(viewModel: viewModel)
                    }
                }
        }
        .frame(width: width)
    }
}

