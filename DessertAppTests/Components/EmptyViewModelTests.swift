import XCTest
import SwiftUI
@testable import DessertApp

class EmptyViewModelTests: XCTestCase {
    
    var viewModel: EmptyViewModel!
    
    override func setUp() {
        let action = {
            
        }
        
        let isPresented = Binding<Bool>.constant(true)
        self.viewModel = EmptyViewModel(buttonAcction: action, isPresented: isPresented)
    }
    
    func testTexts() {
        XCTAssertEqual(self.viewModel.alertText, "Couldn't load list of desserts.")
        XCTAssertEqual(self.viewModel.alertButton, "Try again")
    }
    
    func testButtonAction() {
        let expectation = expectation(description: "should execute action")
        
        let action = {
            expectation.fulfill()
        }
        
        self.viewModel = EmptyViewModel(buttonAcction: action, isPresented: Binding<Bool>.constant(false))
        
        self.viewModel.buttonAcction()
        
        waitForExpectations(timeout: 0.1)
    }
    
}
