import Foundation

@Observable final class AuraAPIClient {
    var baseURL = URL(string: "https://aura.kreatix.dev/api")!
    var token: String?
    private let session: URLSession
    init(session: URLSession = .shared) { self.session = session }

    func buckets() async throws -> [B2Bucket] { try await get("/buckets") }
    func files(in bucket: B2Bucket, prefix: String? = nil) async throws -> [B2File] {
        var path = "/buckets/\(bucket.id)/files"
        if let prefix { path += "?prefix=\(prefix.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? prefix)" }
        return try await get(path)
    }
    func status() async throws -> VPSStatus { try await get("/status") }

    private func get<T: Decodable>(_ path: String) async throws -> T {
        var request = URLRequest(url: baseURL.appendingPathComponent(path))
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        if let token { request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization") }
        let (data, response) = try await session.data(for: request)
        guard let http = response as? HTTPURLResponse, (200..<300).contains(http.statusCode) else { throw URLError(.badServerResponse) }
        return try JSONDecoder.aura.decode(T.self, from: data)
    }
}

private extension JSONDecoder {
    static var aura: JSONDecoder { let d = JSONDecoder(); d.dateDecodingStrategy = .iso8601; return d }
}
