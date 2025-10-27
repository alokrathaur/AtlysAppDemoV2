import Foundation

struct Country: Identifiable, Hashable {
    let id = UUID()
    let imageUrl: String
    let countryName: String
    
    init(imageUrl: String, countryName: String = "Malaysia") {
        self.imageUrl = imageUrl
        self.countryName = countryName
    }
}
