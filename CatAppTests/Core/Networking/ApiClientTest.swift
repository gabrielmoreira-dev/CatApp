@testable import CatApp
import XCTest

final class ApiClientTest: XCTestCase {
    private lazy var sut: ApiClient = {
        ApiClient(session: sessionStub)
    }()
    
    private lazy var sessionStub: URLSessionStub = {
        URLSessionStub()
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
    
    func testFetchData_WhenInvalidData_ThenThrowError() async {
        sessionStub.successData = Data()
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
        sessionStub.successData = JSONLoader.load(from: "cat_response", for: Self.self)
        let endpoint = EndpointDummy.validPath
        
        let response: [CatResponse] = try await sut.fetchData(from: endpoint)
        
        XCTAssertEqual(response, [.dummy])
    }
}

private enum EndpointDummy: String, EndpointType {
    case invalidPath = "invalid"
    case validPath = "/valid"
    
    var path: String { rawValue }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem] { [] }
}
