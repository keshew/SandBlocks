import SwiftUI

class LevelViewModel: ObservableObject {
    let contact = LevelModel()
    @Published var isMenuAvailible = false
    @Published var isGamevailible = false
    @Published var time = UserDefaultsManager.defaults.object(forKey: Keys.numberOfLevel.rawValue) as! Int - 1
  

    func goToMenu() {
        isMenuAvailible = true
    }
    
    func goToGame() {
        isGamevailible = true
    }
    
    func setupLevel(index: Int) -> (String, Bool) {
        var сarthageLevel: (String, Bool) = ("", true)
        if index == time {
            сarthageLevel = (ImageName.smallButtonForLevelsImage.rawValue, false)
        } else if time > index {
            сarthageLevel = (ImageName.smallButtonForLevelsImage.rawValue, true)
            
        } else {
            сarthageLevel = (ImageName.lockedLevel.rawValue, true)
        }
        return сarthageLevel
    }
    
    func searchForImage() -> String {
        var imageBack = ImageName.levelBackgroundImage.rawValue
        if time < 4 {
            imageBack = ImageName.levelBackgroundImage.rawValue
        } else if time >= 4, time < 7 {
            imageBack = ImageName.levelBackgroundImage2.rawValue
        } else if time >= 7, time < 10 {
            imageBack = ImageName.levelBackgroundImage3.rawValue
        } else if time >= 10 {
            imageBack = ImageName.levelBackgroundImage4.rawValue
        }
        return imageBack
    }
}
