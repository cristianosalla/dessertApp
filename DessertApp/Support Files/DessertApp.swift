import SwiftUI

@main
struct DessertApp: App {
    var body: some Scene {
        WindowGroup {
            let coordinator = Coordinator()
            coordinator.goToDessertList()
        }
    }
}
