import SwiftUI

struct WinView: View {
    @StateObject var WinModel =  WinViewModel()

    var body: some View {
        Text("Hey, Genius")
    }
}

#Preview {
    WinView()
}

