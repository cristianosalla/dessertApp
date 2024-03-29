import SwiftUI

struct PickerTimeView: View {
    
    @Binding var rotationAngle: Angle
    @Binding var progress: Double
    
    var progressFraction: Double {
        return progress/10
    }
    
    let width: CGFloat
    
    var sliderWidth: CGFloat {
        return width * 0.1
    }
    var radius: CGFloat {
        return (width/2.0) * 0.9
    }
    
    var body: some View {
        ZStack {
            
            Circle()
                .trim(from: 0, to: progressFraction)
                .stroke(Color(hue: 0.0, saturation: 0.5, brightness: 0.9),
                        style: StrokeStyle(lineWidth: sliderWidth, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: -90))
            
            Circle()
                .fill(Color.white)
                .shadow(radius: (sliderWidth * 0.3))
                .frame(width: sliderWidth, height: sliderWidth)
                .offset(y: -radius)
                .rotationEffect(rotationAngle)
                .gesture(
                    DragGesture(minimumDistance: 0.0)
                        .onChanged() { value in
                            changeAngle(location: value.location)
                        }
                )
        }
        .frame(width: radius * 2.0, height: radius * 2.0, alignment: .center)
        .padding(radius * 0.1)

    }
    
    func changeAngle(location: CGPoint) {
        let vector = CGVector(dx: location.x, dy: -location.y)
        let angleRadians = atan2(vector.dx, vector.dy)
        let positiveAngle = angleRadians < 0.0 ? angleRadians + (2.0 * .pi) : angleRadians
        $progress.wrappedValue =  positiveAngle / 2.0 * .pi
        $rotationAngle.wrappedValue = Angle(radians: positiveAngle)
    }
}
