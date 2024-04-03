import SwiftUI

fileprivate enum Constants {
    static let width: CGFloat = 128
    static let sizeFactor: CGFloat = 2
    static let radiusFactor: CGFloat = 0.45
    static let sliderFactor: CGFloat = 0.1
}

struct RingView<ViewModel: TimerViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var radius: CGFloat
    var sliderWidth: CGFloat
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel

        self.radius = Constants.width * Constants.radiusFactor
        self.sliderWidth = Constants.width * Constants.sliderFactor
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: sliderWidth))
                .foregroundStyle(.tertiary)
                .frame(width: radius * Constants.sizeFactor, height: radius * Constants.sizeFactor, alignment: .center)
                .overlay {
                    if viewModel.isRunning {
                        RingAnimationView(viewModel: viewModel, sliderWidth: sliderWidth)
                    } else {
                        PickerTimeView(viewModel: viewModel, width: Constants.width, sliderWidth: sliderWidth, radius: radius)
                    }
                }
        }
        .frame(width: Constants.width)
    }
}

