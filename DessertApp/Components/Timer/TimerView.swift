import SwiftUI
import Combine

struct TimerView: View {
    
    enum Constants {
        static let defaultTimer: TimeInterval = 0
        static let defaultProgress: Double = 0
        static let scheduleTimeInterval: TimeInterval = 1
        static let ringWidth: CGFloat = 128
        static let buttonWidth: CGFloat = 30
    }
    
    @State var isRunning = false
    @State var progress: Double = .zero
    
    @State private var elapsedTime: TimeInterval = .zero
    @State private var timer: AnyCancellable?
    
    var body: some View {
        VStack {
            ZStack {
                RingView(isRunning: $isRunning, progress: $progress, width: Constants.ringWidth)
                Text(setText())
            }
            
            PlayPauseButtonView(isRunning: $isRunning, action: {
                isRunning.toggle()
                startTimer()
            })
        }
    }
    
    func setText() -> String {
        return isRunning ? elapsedTime.toString() : progress.toTimeInterval().toString()
    }
    
    func startTimer() {
        let setTime = progress.toTimeInterval()
        let time = Date.now
        self.elapsedTime = progress.toTimeInterval()
        
        self.timer = Timer.publish(every: .one, on: RunLoop.main, in: .common).autoconnect().sink(receiveValue: { _ in
            if isRunning {
                self.elapsedTime = setTime - Date.now.timeIntervalSince(time)
                isRunning = elapsedTime <= .zero ? false : true
                
            } else {
                timer?.cancel()
            }
        })
    }
        
}
