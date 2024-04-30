import SwiftUI

fileprivate enum Constants {
    static let trim: CGFloat = 10
    static let shadow: CGFloat = 0.3
    static let color: Color = Color(hue: .zero, saturation: 0.5, brightness: 0.9)
    static let frameFactor: CGFloat = 2.0
    static let paddingFactor: CGFloat = 0.1
}

struct PickerTimeView: View {
    
    @EnvironmentObject var viewModel: TimerViewModel
    
    let width: CGFloat
    let sliderWidth: CGFloat
    let radius: CGFloat
    
    init(width: CGFloat, sliderWidth: CGFloat, radius: CGFloat) {
        self.width = width
        self.sliderWidth = sliderWidth
        self.radius = radius
    }
    
    var body: some View {
        ZStack {
            
            Circle()
                .trim(from: .zero, to: viewModel.progress/Constants.trim)
                .stroke(Constants.color,
                        style: StrokeStyle(lineWidth: sliderWidth, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: -.ninety))
            
            Circle()
                .fill(Color.white)
                .shadow(radius: (sliderWidth * Constants.shadow))
                .frame(width: sliderWidth, height: sliderWidth)
                .offset(y: -radius)
                .rotationEffect(viewModel.rotationAngle)
                .gesture(
                    DragGesture(minimumDistance: .zero)
                        .onChanged() { value in
                            viewModel.changeAngle(location: value.location)
                        }
                )
        }
        .frame(width: radius * Constants.frameFactor, height: radius * Constants.frameFactor, alignment: .center)
        .padding(radius * Constants.paddingFactor)
        
    }
    
}
