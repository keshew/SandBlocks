import SwiftUI

class RulesViewModel: ObservableObject {
    let contact = RulesModel()
    @Published var isMenuAvailible = false

    func goToMenu() {
        isMenuAvailible = true
    }
}
