import SwiftUI

@main
struct AuraApp: App {
    @State private var api = AuraAPIClient()
    var body: some Scene {
        WindowGroup { RootView().environment(api) }
    }
}

struct RootView: View {
    var body: some View {
        TabView {
            BucketsView().tabItem { Label("Storage", systemImage: "square.stack.3d.up") }
            SettingsView().tabItem { Label("Settings", systemImage: "gearshape") }
        }
        .preferredColorScheme(.dark)
        .tint(.cyan)
    }
}
