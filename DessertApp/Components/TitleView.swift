import SwiftUI

struct TitleView: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.mealTitle)
            .padding()
    }
}

struct DetailsTitleView: View {
    
    var title: String
    
    var body: some View {
        ZStack {
            Image("titleBackground", bundle: nil)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .foregroundStyle(Color.black)
                .font(.mealTitle)
                .minimumScaleFactor(0.01)
                .frame(maxWidth: 230, maxHeight: 40)
                .frame(alignment: .bottom)
        }
        .frame(width: 400, height: 200)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsTitleView(title: "My Title")
    }
}
