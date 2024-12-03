import SwiftUI

class WinViewModel: ObservableObject {
    let contact = WinModel()
    @Published var isMenuAvailible = false

    func goToMenu() {
        isMenuAvailible = true
    }
}
