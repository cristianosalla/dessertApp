import Combine
import SwiftUI
import Foundation


class TimerViewModel: TimerViewModelProtocol {
  
    enum Constants {
        static let defaultTimer: TimeInterval = 0
        static let defaultProgress: Double = 0
        static let scheduleTimeInterval: TimeInterval = 1
        static let ringWidth: CGFloat = 128
        static let buttonWidth: CGFloat = 30
    }
    
    var ringWidth: CGFloat = 128

    @Published var isRunning: Bool = false
    @Published var progress: Double = 0.0
    @Published var elapsedTime: TimeInterval = 0.0
    @Published var timer: AnyCancellable?
    @Published var rotationAngle: Angle = .degrees(0)
    
    func setText() -> String {
        return isRunning ? elapsedTime.toString() : progress.toTimeInterval().toString()
    }
    
    func startTimer() {
        self.isRunning = true
        let setTime = progress.toTimeInterval()
        let time = Date.now
        self.elapsedTime = progress.toTimeInterval()
        
        self.timer = Timer.publish(every: .one, on: RunLoop.main, in: .common).autoconnect().sink(receiveValue: { [self] _ in
            if self.isRunning {
                self.elapsedTime = setTime - Date.now.timeIntervalSince(time)
                isRunning = elapsedTime <= .zero ? false : true
                
            } else {
                timer?.cancel()
            }
        })
    }
    
    func changeAngle(location: CGPoint) {
        let vector = CGVector(dx: location.x, dy: -location.y)
        let angleRadians = atan2(vector.dx, vector.dy)
        let positiveAngle = angleRadians < 0.0 ? angleRadians + (2.0 * .pi) : angleRadians
        progress =  positiveAngle / 2.0 * .pi
        rotationAngle = Angle(radians: positiveAngle)
    }
}
