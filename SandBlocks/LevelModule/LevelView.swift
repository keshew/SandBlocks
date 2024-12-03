import SwiftUI

struct LevelView: View {
    @StateObject var LevelModel =  LevelViewModel()

    var body: some View {
        Text("Hey, Genius")
    }
}

#Preview {
    LevelView()
}

