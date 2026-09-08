import SwiftUI

struct BucketsView: View {
    @Environment(AuraAPIClient.self) private var api
    @State private var model = BucketsViewModel()
    var body: some View {
        NavigationStack {
            Group {
                if model.isLoading { ProgressView().controlSize(.large) }
                else { List(model.buckets) { bucket in NavigationLink(value: bucket) { BucketRow(bucket: bucket) } }.listStyle(.plain) }
            }
            .navigationTitle("Aura")
            .navigationDestination(for: B2Bucket.self) { BucketDetailView(bucket: $0) }
            .toolbar { ToolbarItem(placement: .topBarTrailing) { Button { Task { await model.load(using: api) } } label: { Image(systemName: "arrow.clockwise") }.sensoryFeedback(.impact, trigger: model.isLoading) } }
            .task { await model.load(using: api) }
        }
    }
}
struct BucketRow: View { let bucket: B2Bucket; var body: some View { HStack { Image(systemName: "folder.fill").foregroundStyle(.cyan); VStack(alignment: .leading) { Text(bucket.name).font(.headline); Text(bucket.type ?? "B2 bucket").font(.caption).foregroundStyle(.secondary) }; Spacer(); Image(systemName: "chevron.right").foregroundStyle(.tertiary) }.padding(.vertical, 8) } }
