@testable import CatApp
import XCTest

final class ApiClientTest: XCTestCase {
    private lazy var sut: ApiClient = {
        ApiClient(dependencies: dependencies)
    }()

    private lazy var dependencies: DependencyContainerStub = {
        DependencyContainerStub()
    }()

    func testFetchData_WhenInvalidURL_ThenThrowError() async {
        let endpoint = EndpointDummy.invalidPath
        var expectedError: Error?
        
        do {
            let _: [CatResponse] = try await sut.fetchData(from: endpoint)
        } catch {
            expectedError = error
        }
        
        XCTAssertNotNil(expectedError)
        XCTAssert((expectedError as? CatAppError) == .invalidURL)
    }
    
    func testFetchData_WhenServerError_ThenThrowError() async {
        let endpoint = EndpointDummy.validPath
        var expectedError: Error?
        
        do {
            let _: [CatResponse] = try await sut.fetchData(from: endpoint)
        } catch {
            expectedError = error
        }
        
        XCTAssertNotNil(expectedError)
    }

    func testFetchData_WhenInternetError_ThenThrowError() async {
        dependencies.sessionStub?.error = URLError(URLError.Code(rawValue: NSURLErrorNotConnectedToInternet))
        let endpoint = EndpointDummy.validPath
        var expectedError: Error?

        do {
            let _: [CatResponse] = try await sut.fetchData(from: endpoint)
        } catch {
            expectedError = error
        }

        XCTAssertNotNil(expectedError)
    }

    func testFetchData_WhenInvalidData_ThenThrowError() async {
        dependencies.sessionStub?.successData = Data()
        let endpoint = EndpointDummy.validPath
        var expectedError: Error?
        
        do {
            let _: [CatResponse] = try await sut.fetchData(from: endpoint)
        } catch {
            expectedError = error
        }
        
        XCTAssertNotNil(expectedError)
    }
    
    func testFetchData_WhenSuccess_ThenReturnOnject() async throws {
        dependencies.sessionStub?.successData = JSONLoader.load(from: "cat_response", for: Self.self)
        let endpoint = EndpointDummy.validPath
        
        let response: [CatResponse] = try await sut.fetchData(from: endpoint)
        
        XCTAssertEqual(response, [CatResponse.dummy])
    }
}

private enum EndpointDummy: String, EndpointType {
    case invalidPath = "invalid"
    case validPath = "/valid"
    
    var path: String { rawValue }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem] { [] }
}
