import SwiftUI

class GameViewModel: ObservableObject {
    let contact = GameModel()
    @Published var isMenuAvailible = false

    func goToMenu() {
        isMenuAvailible = true
    }
    
    func createGameScene(gameData: GameData) -> GameSpriteKit {
        let scene = GameSpriteKit()
        scene.game  = gameData
        return scene
    }
}
