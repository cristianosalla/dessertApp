import SwiftUI

struct PlayButtonView: View {
    
    var title: String
    var url: String?
    @State private var isPresented: Bool = false
    
    var body: some View {
        
        Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "play.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .foregroundColor(.white)
                .shadow(radius: 3)
                .opacity(0.7)
        }).sheet(isPresented: $isPresented) {
            if #available(iOS 16.0, *) {
                NavigationStack {
                    if let url = URL(string: url ?? "") {
                        WebView(url: url)
                            .ignoresSafeArea()
                            .navigationTitle(title)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            } else {
                // Fallback on earlier versions
            }
        }
        
    }
}
