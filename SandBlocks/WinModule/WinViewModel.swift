import SwiftUI

class WinViewModel: ObservableObject {
    let contact = WinModel()
    @Published var isMenuAvailible = false
    @Published var isLevelAvailible = false
    @Published var coin = UserDefaultsManager.defaults.object(forKey: Keys.countOfMoney.rawValue)

    func goToMenu() {
        isMenuAvailible = true
        UserDefaultsManager().completeLevel()
    }
    
    func goToLevel() {
        isLevelAvailible = true
        UserDefaultsManager().completeLevel()
    }
}
