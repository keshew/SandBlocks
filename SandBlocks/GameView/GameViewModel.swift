import SwiftUI

class GameViewModel: ObservableObject {
    let contact = GameModel()
    @Published var isMenuAvailible = false

    func goToMenu() {
        isMenuAvailible = true
    }
}
