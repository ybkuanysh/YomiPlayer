import Foundation

public extension URL {
    static func previewVideo() -> URL? {
        return Bundle.module.url(forResource: "video", withExtension: "mp4")
    }
    
    static func previewSubtitles() -> URL? {
        return Bundle.module.url(forResource: "subtitles", withExtension: "srt")
    }
}
