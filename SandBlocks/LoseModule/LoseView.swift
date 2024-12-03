import SwiftUI

struct LoseView: View {
    @StateObject var LoseModel =  LoseViewModel()

    var body: some View {
        Text("Hey, Genius")
    }
}

#Preview {
    LoseView()
}

