import Foundation

final class JSONLoader {
    private init() { }
    
    static func load(from file: String, for aClass: AnyClass) -> Data? {
        guard let url = Bundle(for: aClass).url(forResource: file, withExtension: "json") else {
            return nil
        }
        return try? Data(contentsOf: url)
    }
}
