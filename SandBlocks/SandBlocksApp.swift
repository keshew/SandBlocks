import SwiftUI

@main
struct SandBlocksApp: App {
    var body: some Scene {
        WindowGroup {
            MenuView()
                .onAppear() {
                    UserDefaultsManager().firstLaunch()
                }
        }
    }
}
