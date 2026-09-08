import SwiftUI

struct SettingsView: View {
    @Environment(AuraAPIClient.self) private var api
    @State private var status: VPSStatus?
    var body: some View { NavigationStack { Form { Section("Connection") { Text(api.baseURL.absoluteString).font(.footnote); Button("Check VPS status") { Task { status = try? await api.status() } } }; Section("Status") { Label(status?.online == true ? "Online" : "Not checked", systemImage: status?.online == true ? "checkmark.circle.fill" : "circle") } }.navigationTitle("Settings") } }
}
