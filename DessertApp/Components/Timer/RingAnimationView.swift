import SwiftUI

struct RingAnimationView<ViewModel: TimerViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var animate = false
    
    let sliderWidth: CGFloat
    let lime = Color(#colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1))
    
    init(viewModel: ViewModel, sliderWidth: CGFloat) {
        self.viewModel = viewModel
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
