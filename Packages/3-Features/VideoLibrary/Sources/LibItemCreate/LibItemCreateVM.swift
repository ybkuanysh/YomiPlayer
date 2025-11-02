import Foundation
import Navigation
import YomiComponents
import YomiDatabase
import YomiModels

public final class LibItemCreateViewModel: ObservableObject {
    let dataSource: YomiLibraryDataSource
    var router: Router?
    private var subtitles: URL?
    private var video: URL?

    @Published var data = LibItemCreateData()

    init(dataSource: YomiLibraryDataSource) {
        self.dataSource = dataSource
        self.router = nil
    }
}

extension LibItemCreateViewModel: LibItemCreateActions {
    func selectFile(_ type: DocumentType) {
        data.fileTypeToSelect = type
        data.docPickerPresented = true
    }

    func handleFileSelection(_ result: Result<URL, any Error>) {
        switch result {
        case .success(let url):
            switch data.fileTypeToSelect {
            case .video:
                video = url
                data.videoName = url.lastPathComponent
            case .subtitle:
                subtitles = url
                data.subtitleName = url.lastPathComponent
            default: break
            }
        case .failure:
            fatalError("Failure selecting file")
        }
    }

    private func getSecurityScoped(resource url: URL) -> Bookmark {
        guard url.startAccessingSecurityScopedResource() else {
            fatalError("Can't access video URL")
        }
        defer { url.stopAccessingSecurityScopedResource() }

        do {
            let data = try url.bookmarkData(
                options: .minimalBookmark,
                includingResourceValuesForKeys: nil,
                relativeTo: nil
            )
            return Bookmark(data)
        } catch {
            fatalError("Can't create bookmark")
        }
    }

    func saveAndContinue() {
        guard let selectedVideo = video else { return }
        guard let selectedSubs = subtitles else { return }
        let item = YomiLibraryItem(
            name: data.videoName!,
            video: getSecurityScoped(resource: selectedVideo),
            subtitles: getSecurityScoped(resource: selectedSubs)
        )
        do { try dataSource.insert(item) } catch {
            fatalError("Failed to insert item: \(error)")
        }
        router?.navigate(to: .fullScreen(.player(libraryItem: item)))
    }
}
