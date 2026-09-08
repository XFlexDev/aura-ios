import SwiftUI

struct BucketDetailView: View {
    let bucket: B2Bucket
    @Environment(AuraAPIClient.self) private var api
    @State private var files: [B2File] = []; @State private var loading = true
    var body: some View {
        List(files) { file in NavigationLink { FilePreviewView(file: file) } label: { HStack { Image(systemName: "doc"); VStack(alignment: .leading) { Text(file.fileName); Text(ByteCountFormatter.string(fromByteCount: file.size, countStyle: .file)).font(.caption).foregroundStyle(.secondary) } } } }
        .navigationTitle(bucket.name).task { do { files = try await api.files(in: bucket) } catch {}; loading = false }.overlay { if loading { ProgressView() } }
    }
}
struct FilePreviewView: View { let file: B2File; var body: some View { VStack(spacing: 16) { Image(systemName: "doc.richtext").font(.system(size: 56)).foregroundStyle(.cyan); Text(file.fileName).font(.title3.bold()); Text(file.contentType ?? "Unknown type").foregroundStyle(.secondary); Spacer() }.padding().navigationTitle("Preview") } }
