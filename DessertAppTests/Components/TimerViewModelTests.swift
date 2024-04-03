import XCTest
import SwiftUI
@testable import DessertApp

class TimerViewModelTests: XCTestCase {
    
    var viewModel: TimerViewModel!
    
    override func setUp() {
        self.viewModel = TimerViewModel()
    }
    
    func testButtonActionRunning() {
        self.viewModel.isRunning = true
        viewModel.buttonActon()
        XCTAssertEqual(viewModel.isRunning, false)
    }
    
    func testButtonActionNotRunning() {
        self.viewModel.isRunning = false
        viewModel.buttonActon()
        XCTAssertNotNil(viewModel.timer)
        XCTAssertEqual(viewModel.isRunning, true)
    }
    
    func testChangeAngle() {
        let location = CGPoint.init(x: 1.0, y: 1.0)
        
        self.viewModel.changeAngle(location: location)
        
        XCTAssertEqual(viewModel.progress, 3.7011016504085092)
        XCTAssertEqual(viewModel.rotationAngle, .radians(2.356194490192345))
    }
    
    func testStartTimer() {
        viewModel.progress = 1.0
        viewModel.isRunning = false
        
        viewModel.startTimer()
        
        XCTAssertTrue(viewModel.isRunning)
        XCTAssertNotNil(viewModel.timer)
        XCTAssertEqual(viewModel.elapsedTime, viewModel.progress.toTimeInterval())
    }
    
    func testSetTimer() {
        let setTime: TimeInterval = 5
        viewModel.setTimer(setTime)
        
        XCTAssertNotNil(viewModel.timer)
    }
    
    func testTimerActionIsRunning() {
        viewModel.isRunning = true
        viewModel.timerAction(setTime: 2, time: Date.now)
        
        XCTAssertEqual(viewModel.elapsedTime, 2.0)
    }
    
    func testTimerActionIsNotRunning() {
        viewModel.isRunning = false
        viewModel.timerAction(setTime: 2, time: Date.now)
        
        XCTAssertNil(viewModel.timer)
    }
    
    func testSetTextRunning() {
        viewModel.isRunning = true
        viewModel.elapsedTime = 1.0
        viewModel.progress = 3.0
        
        XCTAssertEqual(viewModel.setText(), viewModel.elapsedTime.toString())
    }
    
    func testSetTextNotRunning() {
        viewModel.isRunning = false
        viewModel.elapsedTime = 1.0
        viewModel.progress = 3.0
        
        XCTAssertEqual(viewModel.setText(), viewModel.progress.toTimeInterval().toString())
    }
    
}
