import SwiftUI

@available(iOS 17.0, *)
@main
struct MealApp: App {
    var body: some Scene {
        WindowGroup {
            let coordinator = Coordinator()
            coordinator.goToCategory()
        }
    }
}
