import Foundation

struct LocalResponse: Codable {
    let data: Data?
    let error: CatAppError

    init(data: Data?, error: CatAppError = .generic) {
        self.data = data
        self.error = error
    }
}
