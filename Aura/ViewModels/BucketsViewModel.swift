import Foundation

@MainActor @Observable final class BucketsViewModel {
    var buckets: [B2Bucket] = []; var isLoading = false; var error: Error?
    func load(using api: AuraAPIClient) async { isLoading = true; defer { isLoading = false }; do { buckets = try await api.buckets() } catch { self.error = error } }
}
