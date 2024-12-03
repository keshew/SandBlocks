import SwiftUI

class LoseViewModel: ObservableObject {
    let contact = LoseModel()
    @Published var isMenuAvailible = false

    func goToMenu() {
        isMenuAvailible = true
    }
}
