import Foundation

struct B2Bucket: Identifiable, Codable, Hashable { let id: String; let name: String; let type: String?; let fileCount: Int? }
struct B2File: Identifiable, Codable, Hashable { let id: String; let fileName: String; let size: Int64; let contentType: String?; let uploadTimestamp: Date?; let downloadURL: URL? }
struct VPSStatus: Codable { let online: Bool; let version: String?; let latencyMs: Int? }
