import SwiftUI
import Navigation
import YomiModels

protocol LibraryActions: AnyObject {
    func delete(at offsets: IndexSet) -> Void
    func loadLibrary() -> Void
}

struct LibraryView: View {
    var library: [YomiLibraryItem]
    var actions: LibraryActions?
    
    var body: some View {
        List {
            ForEach(library, id: \.id) { item in
                NavigationButton(fullScreen: .player(libraryItem: item)) {
                    HStack {
                        Text(item.name)
                        Spacer()
                        if item.subtitles != nil {
                            Image(systemName: "film.fill")
                                .overlay(alignment: .bottomTrailing) {
                                    Image(systemName: "captions.bubble.fill")
                                        .font(.system(size: 12))
                                        .offset(x: 5, y: 5)
                                }
                        } else {
                            Image(systemName: "film.fill")
                        }
                    }
                }
            }
            .onDelete(perform: { index in
                actions?.delete(at: index)
            })
        }
        .onAppear { actions?.loadLibrary() }
        .overlay {
            if library.isEmpty {
                ContentUnavailableView(
                    label: {
                        Label(
                            "No recent files",
                            systemImage: "questionmark.folder"
                        )
                        .foregroundStyle(.secondary)
                    }
                )
                .background(
                    Color(.systemGroupedBackground)
                        .ignoresSafeArea()
                )
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationButton(push: .addVideo) {
                    Label("Select File", systemImage: "document.badge.plus")
                }
            }
        }
        .navigationTitle("Library")
    }
}

#Preview {
    NavigationStack {
        LibraryView(library: [.previewValue()])
            .environment(Router.previewRouter())
    }
}
