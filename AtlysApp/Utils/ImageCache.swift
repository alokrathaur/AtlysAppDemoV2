import SwiftUI
import Combine

class ImageCache: ObservableObject {
    static let shared = ImageCache()
    private var cache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024 // 50 MB
    }
    
    func get(url: String) -> UIImage? {
        return cache.object(forKey: url as NSString)
    }
    
    func set(url: String, image: UIImage) {
        cache.setObject(image, forKey: url as NSString)
    }
}
