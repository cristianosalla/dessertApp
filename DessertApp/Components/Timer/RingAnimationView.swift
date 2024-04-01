import SwiftUI

struct RingAnimationView: View {
    
    @Binding var progress: Double
    let sliderWidth: CGFloat
    
    @State var animate = false
    let lime = Color(#colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1))
    
    var body: some View {
        Circle()
            .trim(from: .zero, to: animate ? 1 : .zero)
            .stroke(
                lime.gradient,
                style: StrokeStyle(lineWidth: sliderWidth, lineCap: .round)
            )
            .animation(
                .linear(duration: progress.toTimeInterval()),
                value: animate
            )
            .onAppear() {
                animate = true
            }
            .onDisappear() {
                animate = false
            }
            .rotationEffect(.degrees(-90))
    }
}
