import SwiftUI

class LevelViewModel: ObservableObject {
    let contact = LevelModel()
    @Published var isMenuAvailible = false

    func goToMenu() {
        isMenuAvailible = true
    }
}
