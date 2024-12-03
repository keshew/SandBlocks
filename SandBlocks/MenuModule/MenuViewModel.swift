import SwiftUI

class MenuViewModel: ObservableObject {
    let contact = MenuModel()
    @Published var isMenuAvailible = false

    func goToMenu() {
        isMenuAvailible = true
    }
}
