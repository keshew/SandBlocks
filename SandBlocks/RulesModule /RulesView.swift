import SwiftUI

struct RulesView: View {
    @StateObject var RulesModel =  RulesViewModel()

    var body: some View {
        Text("Hey, Genius")
    }
}

#Preview {
    RulesView()
}

