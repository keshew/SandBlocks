import SwiftUI

class MenuViewModel: ObservableObject {
    let contact = MenuModel()
    @Published var isMenuAvailible = false
    @Published var isSoundAvailible = false
    @Published var isMusicAvailible = false
    @Published var isLevelsAvailible = false
    @Published var isGameAvailible = false
    
    func goToGame() {
        isGameAvailible = true
    }
    
    func enableSound() {
        isSoundAvailible = true
    }
    
    func enableMusic() {
        isMusicAvailible = true
    }
    
    func goToLevel() {
        isLevelsAvailible = true
    }
}
