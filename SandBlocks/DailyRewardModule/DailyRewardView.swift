import SwiftUI

struct DailyRewardView: View {
    @StateObject var DailyRewardModel =  DailyRewardViewModel()

    var body: some View {
        Text("Hey, Genius")
    }
}

#Preview {
    DailyRewardView()
}

