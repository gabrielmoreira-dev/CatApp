protocol ServiceType<Input, Output> {
    associatedtype Input
    associatedtype Output
    
    func fetchData(input: Input) async throws -> Output
}
