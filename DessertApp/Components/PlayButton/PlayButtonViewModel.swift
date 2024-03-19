import Foundation

class PlayButtonViewModel: PlayButtonViewModelProtocol {
    
    var title: String
    var url: String
    @Published var isPresented: Bool = false
    var iconName: String = "play.circle.fill"
    
    init(title: String, url: String) {
        self.title = title
        self.url = url
    }
}
