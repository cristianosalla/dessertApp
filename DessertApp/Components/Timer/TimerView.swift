import SwiftUI


struct TimerView: View {
    
    enum Constants {
        static let defaultTimer: TimeInterval = 0
        static let defaultProgress: Double = 0
        static let scheduleTimeInterval: TimeInterval = 1
        static let ringWidth: CGFloat = 128
        static let buttonWidth: CGFloat = 30
    }
    
    @State var isRunning = false
    @State var progress: Double = 0
    
    @State private var elapsedTime: TimeInterval = 0
    @State private var timerIsRunning = false
    @State private var timer: Timer?

    var body: some View {
        VStack {
            ZStack {
                RingView(isRunning: $isRunning, progress: $progress, width: Constants.ringWidth)
                if isRunning {
                    Text(elapsedTime.toString())
                } else {
                    Text(progress.toTimeInterval().toString())
                }
            }
            
            PlayPauseButtonView(isRunning: $isRunning, action: {
                isRunning.toggle()
                startTimer()
            })
        }
    }
    
    func startTimer() {
        elapsedTime = progress.toTimeInterval()
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if isRunning {
                elapsedTime -= 1
                isRunning = elapsedTime <= 0 ? false : true
            } else {
                timer.invalidate()
            }
        }
    }
        
}
