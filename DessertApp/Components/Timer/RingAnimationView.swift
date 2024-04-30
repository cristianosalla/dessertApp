import SwiftUI

struct RingAnimationView: View {
    
    @EnvironmentObject var viewModel: TimerViewModel
    @State var animate = false
    
    let sliderWidth: CGFloat
    let lime = Color(#colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1))
    
    init(sliderWidth: CGFloat) {
        self.sliderWidth = sliderWidth
    }
    
    var body: some View {
        Circle()
            .trim(from: .zero, to: animate ? .one : .zero)
            .stroke(
                lime.gradient,
                style: StrokeStyle(lineWidth: sliderWidth, lineCap: .round)
            )
            .animation(
                .linear(duration: viewModel.progress.toTimeInterval()),
                value: animate
            )
            .onAppear() {
                animate = true
            }
            .onDisappear() {
                animate = false
            }
            .rotationEffect(.degrees(-.ninety))
    }
}
