import SwiftUI


struct TimerView: View {
    
    @State var isRunning = false
    @State var progress: Double = 0
    
    @Namespace var namespace

    @State private var elapsedTime: TimeInterval = 0
    @State private var timerIsRunning = false
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
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
    
    var body: some View {
        VStack {
            ZStack {
                RingView(isRunning: $isRunning, progress: $progress, width: 128)
                if isRunning {
                    Text(elapsedTime.toString())
                        .onAppear() {
                            elapsedTime = progress.toTimeInterval()
                            self.startTimer()
                        }
                } else {
                    Text(progress.toTimeInterval().toString())
                }
            }
            
            Button(action: {
                isRunning.toggle()
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
        
}
