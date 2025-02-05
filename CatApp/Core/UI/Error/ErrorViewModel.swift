import SwiftUI

extension ErrorViewModel {
    enum Constants {
        static let geneircErrorTitle = String(localized: "Something went wrong")
        static let geneircErrorDescription = String(localized: "We are working to resolve the issue")
        static let internetErrorTitle = String(localized: "It seems like there is no internet")
        static let internetErrorDescription = String(localized: "Check your connection and try again")
        static let buttonTitle = String(localized: "Try again")
    }
}

struct ErrorViewModel: Equatable {
    let error: CatAppError
    let onTryAgain: (() async -> Void)?

    var image: ImageResource {
        switch error {
        case .internet:
            .internetError
        default:
            .genericError
        }
    }

    var title: String {
        switch error {
        case .internet:
            Constants.internetErrorTitle
        default:
            Constants.geneircErrorTitle
        }
    }

    var description: String {
        switch error {
        case .internet:
            Constants.internetErrorDescription
        default:
            Constants.geneircErrorDescription
        }
    }

    var buttonTitle: String {
        Constants.buttonTitle
    }

    static func == (lhs: ErrorViewModel, rhs: ErrorViewModel) -> Bool {
        lhs.error == rhs.error
    }
}
