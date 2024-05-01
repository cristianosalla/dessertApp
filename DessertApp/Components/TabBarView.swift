import SwiftUI

struct TabBarView: View {
    
    var coordinator: Coordinator
    
    var body: some View {
        TabView {
            coordinator.goToCategory()
                .tabItem {
                    Label("Category", systemImage: "list.dash")
                }
            
            coordinator.goToSearchList()
                .tabItem {
                    Label("Search", systemImage: "list.dash")
                }
            
            coordinator.goToGenerateMeal()
                .tabItem {
                    Label("Generate", systemImage: "list.dash")
                }
            
        }
    }
}

