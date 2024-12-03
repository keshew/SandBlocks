import SwiftUI

class ShopViewModel: ObservableObject {
    let contact = ShopModel()
    @Published var isMenuAvailible = false
    @Published var swipeDirection = ("ADDITIONAL TIME", ImageName.timeBuy.rawValue, "SWIPE RIGHT TO NEXT")
    @Published var coin = UserDefaultsManager.defaults.object(forKey: Keys.countOfMoney.rawValue)
    
    func goToMenu() {
        isMenuAvailible = true
        
    }
    
    func changeView(with: Bool) ->  (String, String, String) {
        let carthage: (String, String, String)
        if with {
            carthage = (contact.bonusLabelDouble, contact.imageDouble, contact.swipeDirectionLeft)
        } else {
            carthage = (contact.bonusLabel, contact.image, contact.swipeDirection)
        }
        return carthage
    }
}
