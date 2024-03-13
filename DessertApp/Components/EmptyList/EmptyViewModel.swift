import Foundation
import SwiftUI

class EmptyViewModel: ObservableObject {
    
    var alertText: String { "Couldn't load list of desserts." }
    var alertButton: String { "Try again" }
    var isPresented: Binding<Bool>
    let buttonAcction: (() -> ())
    
    init(buttonAcction: (@escaping () -> ()), isPresented: Binding<Bool>) {
        self.buttonAcction = buttonAcction
        self.isPresented = isPresented
    }
}
