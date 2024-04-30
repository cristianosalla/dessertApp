import Combine
import SwiftUI
import Foundation

class TimerViewModel: ObservableObject {
  
    @Published var isRunning: Bool = false
    @Published var progress: Double = 0.0
    @Published var elapsedTime: TimeInterval = 0.0
    @Published var timer: AnyCancellable?
    @Published var rotationAngle: Angle = .degrees(0)
    
    func setText() -> String {
        return isRunning ? elapsedTime.toString() : progress.toTimeInterval().toString()
    }
    
    func startTimer() {
        isRunning = true
        elapsedTime = progress.toTimeInterval()
        let setTime = progress.toTimeInterval()
        setTimer(setTime)
    }
    
    func setTimer(_ setTime: TimeInterval) {
        let time = Date.now
        
        self.timer = Timer.publish(every: .one, on: RunLoop.main, in: .common).autoconnect().sink(receiveValue: { [self] _ in
            timerAction(setTime: setTime, time: time)
        })
    }
    
    func timerAction(setTime: TimeInterval, time: Date) {
        if self.isRunning {
            elapsedTime = setTime - Date.now.timeIntervalSince(time)
            isRunning = elapsedTime <= .zero ? false : true
        } else {
            timer?.cancel()
            timer = nil
        }
    }
    
    func changeAngle(location: CGPoint) {
        let vector = CGVector(dx: location.x, dy: -location.y)
        let angleRadians = atan2(vector.dx, vector.dy)
        let positiveAngle = angleRadians < 0.0 ? angleRadians + (2.0 * .pi) : angleRadians
        progress =  positiveAngle / 2.0 * .pi
        rotationAngle = Angle(radians: positiveAngle)
    }
    
    func buttonActon() {
        isRunning ? isRunning = false : startTimer()
    }
}
