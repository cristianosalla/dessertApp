import SwiftUI

struct LazyView<Content: View>: View {
    var content: () -> Content
    
    init(_ content: @autoclosure @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        content()
    }
}
