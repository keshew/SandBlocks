import SwiftUI

class DailyRewardViewModel: ObservableObject {
    let contact = DailyRewardModel()
    @Published var isMenuAvailible = false

    
    func goToMenu() {
        isMenuAvailible = true
    }
}
