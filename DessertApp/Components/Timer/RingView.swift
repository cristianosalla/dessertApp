import SwiftUI

struct RingView: View {
    
    @State var rotationAngle = Angle(degrees: 0)
    
    var isRunning: Binding<Bool>
    var progress: Binding<Double>
    
    let width: CGFloat
    let radius: CGFloat
    let sliderWidth: CGFloat
    
    init(isRunning: Binding<Bool>, progress: Binding<Double>, width: CGFloat) {
        self.isRunning = isRunning
        self.progress = progress
        
        self.width = width
        self.radius = (width/2.0) * 0.9
        self.sliderWidth = width * 0.1
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: sliderWidth))
                .foregroundStyle(.tertiary)
                .frame(width: radius * 2.0, height: radius * 2.0, alignment: .center)
                .overlay {
                    if isRunning.wrappedValue {
                        RingAnimationView(progress: progress, sliderWidth: sliderWidth)
                    } else {
                        PickerTimeView(rotationAngle: $rotationAngle, progress: progress, width: width)
                    }
                }
        }
        .frame(width: width)
    }
}

