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
                RingView(isRunning: $isRunning, progress: $progress, width: 128)
                if isRunning {
                    Text(elapsedTime.toString())
                } else {
                    Text(progress.toTimeInterval().toString())
                }
            }
            
            PlayPauseButtonView(isRunning: $isRunning, action: {
                isRunning.toggle()
                startTimer()
//                    .onAppear() {
                        
//                    }
                
            })
        }
    }
    
    func startTimer() {
        elapsedTime = progress.toTimeInterval()
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if isRunning {
                elapsedTime -= 1
                if elapsedTime <= 0  {
                    isRunning = false
                }
            } else {
                timer.invalidate()
            }
        }
    }
        
}

struct PlayPauseButtonView: View {
    
    @Binding var isRunning: Bool    
    var action: (() -> ())

    @Namespace var namespace
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: isRunning ? "stop.circle.fill" : "play.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
                .shadow(radius: 3)
                .matchedGeometryEffect(id: "icon", in: namespace)
        })
    }
}
