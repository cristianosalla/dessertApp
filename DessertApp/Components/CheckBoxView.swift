import SwiftUI

struct CheckBoxView: View {
    
    @State var checked = false
    let fill = Color(#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 0.5))
            .foregroundStyle(.tertiary)
            .frame(width: 30, height: 30, alignment: .center)
            .padding(.leading, 15)
            .onTapGesture {
                checked.toggle()
            }
            .overlay {
                Circle()
                    .foregroundColor(checked ? fill : .clear)
                    .foregroundStyle(.tertiary)
                    .frame(width: 30, height: 30, alignment: .center)
                    .padding(.leading, 15)
                    .onTapGesture {
                        checked.toggle()
                    }
                
            }
    }
    
}
