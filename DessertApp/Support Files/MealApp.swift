import SwiftUI

@main
struct MealApp: App {
    var body: some Scene {
        WindowGroup {
            let coordinator = Coordinator()
            coordinator.goToTabBarView()
        }
    }
}
