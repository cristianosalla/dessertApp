import SwiftUI
import Combine

struct TimerView: View {
    
    @EnvironmentObject var viewModel: TimerViewModel
    
    var body: some View {
        VStack {
            ZStack {
                RingView()
                Text(viewModel.setText())
            }
            PlayPauseButtonView()
        }
    }
}
