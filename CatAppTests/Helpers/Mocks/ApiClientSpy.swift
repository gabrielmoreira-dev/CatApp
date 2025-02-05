@testable import CatApp

final class ApiClientSpy<D: Decodable>: ApiClientType {
    private(set) var receivedEndpoint: EndpointType?
    var successData: D?
    var error: Error = CatAppError.generic

    func fetchData<T: Decodable>(from endpoint: EndpointType) async throws -> T{
        receivedEndpoint = endpoint
        guard let successData = successData as? T else { throw error }
        return successData
    }
}
