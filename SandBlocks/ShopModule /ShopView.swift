import SwiftUI

struct ShopView: View {
    @StateObject var ShopModel =  ShopViewModel()

    var body: some View {
        Text("Hey, Genius")
    }
}

#Preview {
    ShopView()
}

