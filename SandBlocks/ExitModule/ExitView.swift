import SwiftUI

struct ExitView: View {
    @StateObject var ExitModel =  ExitViewModel()

    var body: some View {
        Text("Hey, Genius")
    }
}

#Preview {
    ExitView()
}

