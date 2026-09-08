# Aura iOS

Native SwiftUI client for Aura storage, targeting `https://aura.kreatix.dev/api`.

## Layout
- `AuraApp.swift` — app entry and navigation
- `Models/` — B2 domain models
- `Services/AuraAPIClient.swift` — async API client
- `ViewModels/` — observable state
- `Views/` — dark native UI
- `.github/workflows/build-ipa.yml` — unsigned IPA artifact build

Open `Aura.xcodeproj` in Xcode 16+ (iOS 17+). Configure API authentication in Settings; secrets are never committed.