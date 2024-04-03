import SwiftUI

struct PickerTimeView<ViewModel: TimerViewModelProtocol>: View {
    
    @ObservedObject var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    let width: CGFloat = 128
    
    var sliderWidth: CGFloat {
        return width * 0.1
    }
    var radius: CGFloat {
        return (width/2.0) * 0.9
    }
    
    var body: some View {
        ZStack {
            
            Circle()
                .trim(from: 0, to: viewModel.progress/10)
                .stroke(Color(hue: 0.0, saturation: 0.5, brightness: 0.9),
                        style: StrokeStyle(lineWidth: sliderWidth, lineCap: .round)
                )
                .rotationEffect(Angle(degrees: -90))
            
            Circle()
                .fill(Color.white)
                .shadow(radius: (sliderWidth * 0.3))
                .frame(width: sliderWidth, height: sliderWidth)
                .offset(y: -radius)
                .rotationEffect(viewModel.rotationAngle)
                .gesture(
                    DragGesture(minimumDistance: 0.0)
                        .onChanged() { value in
                            viewModel.changeAngle(location: value.location)
                        }
                )
        }
        .frame(width: radius * 2.0, height: radius * 2.0, alignment: .center)
        .padding(radius * 0.1)

    }
   
}
