import SwiftUI

class LoseViewModel: ObservableObject {
    let contact = LoseModel()
    @Published var isMenuAvailible = false
    @Published var coin = UserDefaultsManager.defaults.object(forKey: Keys.countOfMoney.rawValue)


    func goToMenu() {
        isMenuAvailible = true
    }
    
   
}
