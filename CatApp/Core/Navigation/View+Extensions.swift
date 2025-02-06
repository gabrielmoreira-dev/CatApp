import SwiftUI

extension View {
    func withRouter() -> some View {
        modifier(RouterViewModifier())
    }
}
