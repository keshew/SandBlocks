import SwiftUI

struct MenuView: View {
    @StateObject var MenuModel =  MenuViewModel()

    var body: some View {
        Text("Hey, Genius")
    }
}

#Preview {
    MenuView()
}

