protocol UseCaseType<Input, Output> {
    associatedtype Input
    associatedtype Output

    func execute(input: Input) async throws -> Output
    func onExecute(input: Input) async throws -> Output
}

extension UseCaseType {
    func execute(input: Input) async throws -> Output {
        do {
            return try await onExecute(input: input)
        } catch {
            guard error is CatAppError else {
                throw CatAppError.generic
            }
            throw error
        }
    }
}
