import Foundation

extension ProcessInfo {
    func decode<T: Decodable>(_: T.Type) -> T? {
        guard let json = environment[String(describing: T.self)],
              let data = json.data(using: .utf8),
              let decoded = try? JSONDecoder().decode(T.self, from: data) else {
            return nil
        }
        return decoded
    }
}
