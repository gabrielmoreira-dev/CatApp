enum ViewState: Equatable {
    case success
    case loading
    case failure(CatAppError)
}
