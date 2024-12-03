import SwiftUI

class ShopViewModel: ObservableObject {
    let contact = ShopModel()
    @Published var isMenuAvailible = false

    func goToMenu() {
        isMenuAvailible = true
    }
}
