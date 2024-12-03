import SwiftUI

class ExitViewModel: ObservableObject {
    let contact = ExitModel()
    @Published var isMenuAvailible = false

    func goToMenu() {
        isMenuAvailible = true
    }
}
