import Foundation

extension TimeInterval {
    func toString() -> String {
        let minutes = Int(self) / 60
        let seconds = Int(self) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

extension Double {
    func toTimeInterval() -> TimeInterval {
        let clampedTime = min(max(self, 0), 10)
        let mappedTime = exp(clampedTime * log(7200) / 10)
        return TimeInterval(mappedTime)
    }
}
