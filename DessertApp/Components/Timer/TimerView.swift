import SwiftUI
import Combine

protocol TimerViewModelProtocol: ObservableObject {
    var isRunning: Bool { get set }
    var progress: Double { get set }
    var ringWidth: CGFloat { get set }
    var rotationAngle: Angle { get set }
    var elapsedTime: TimeInterval { get set }
    var timer: AnyCancellable? { get set }
    func setText() -> String
    func startTimer()
    func changeAngle(location: CGPoint)
}

struct TimerView<ViewModel: TimerViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel = TimerViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ZStack {
                RingView(viewModel: viewModel, width: viewModel.ringWidth)
                Text(viewModel.setText())
            }
            
            PlayPauseButtonView(viewModel: viewModel)
        }
    }
}
