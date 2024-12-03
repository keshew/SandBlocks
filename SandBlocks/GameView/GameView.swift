import SwiftUI

struct GameView: View {
    @StateObject var GameModel =  GameViewModel()

    var body: some View {
        Text("Hey, Genius")
    }
}

#Preview {
    GameView()
}

