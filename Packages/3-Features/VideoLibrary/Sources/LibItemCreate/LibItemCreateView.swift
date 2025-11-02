import Navigation
import SwiftUI
import YomiComponents

protocol LibItemCreateActions: AnyObject {
    func selectFile(_ docType: DocumentType)
    func handleFileSelection(_ result: Result<URL, Error>) -> Void
    func saveAndContinue()
}

struct LibItemCreateData {
    var videoName: String?
    var subtitleName: String?
    var docPickerPresented: Bool = false
    var fileTypeToSelect: DocumentType = .video
}

struct LibItemCreateView: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var data: LibItemCreateData
    var actions: LibItemCreateActions?

    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Video")
                    Spacer()
                    Button(data.videoName ?? "Select file") {
                        actions?.selectFile(.video)
                    }
                }
                HStack {
                    Text("Subtitles")
                    Spacer()
                    Button(data.subtitleName ?? "Select file") {
                        actions?.selectFile(.subtitle)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Save") {
                        actions?.saveAndContinue()
                        dismiss()
                    }
                }
            }
            .yomiFileImporter(
                isPresented: $data.docPickerPresented,
                allowedContentTypes: data.fileTypeToSelect
            ) { result in
                actions?.handleFileSelection(result)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LibItemCreateView(data: .constant(.init()))
    }
}
