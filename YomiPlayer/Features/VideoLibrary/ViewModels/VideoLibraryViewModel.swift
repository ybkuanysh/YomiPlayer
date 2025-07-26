//
//  DirectoryListingViewModel.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 26.07.2025.
//

import Foundation
import UIKit
import os

private let logger = Logger.directory

class VideoLibraryViewModel: ObservableObject {
    @Published var entries: [DirectoryEntry] = []
    
    let dto: DirectoryListingDTO
    let root: String
    
    private let manager = FileManager.default
    private var folderObserver: FolderObserver?
    private var documentDir: URL? {
        manager.urls(for: .documentDirectory, in: .userDomainMask).first
    }

    init(dto: DirectoryListingDTO) {
        self.dto = dto
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(reloadLibrary),
            name: UIApplication.didBecomeActiveNotification,
            object: nil
        )
        guard let baseURL = documentDir
        else {
            logger.error("❌ Failed to find documentDirectory")
            return
        }
        folderObserver = FolderObserver(folderURL: baseURL)
        folderObserver?.onChange = { [weak self] in
            DispatchQueue.main.async {
                self?.loadLibrary()
            }
        }
        
        root = dto.name == "/" ? "" : dto.parent + "/"
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    @objc func reloadLibrary() {
        logger.debug("🔄 App became active, reloading library...")
        loadLibrary()
    }

    func loadLibrary() {
        do {
            guard let baseURL = documentDir else {
                logger.error("❌ Failed to find documentDirectory")
                return
            }
            let path = root + dto.name
            let contents = try manager.contentsOfDirectory(
                atPath: path
            )
            let items = contents.map {
                var isDir: ObjCBool = false
                manager.fileExists(
                    atPath: baseURL.path() + "/" + $0,
                    isDirectory: &isDir
                )
                return DirectoryEntry(name: $0, isDir: isDir.boolValue)
            }
            entries = items
        } catch {
            logger.error("LOAD LIBRARY ERROR: \(error)")
        }
    }

    func createFolder(_ name: String, baseURL: URL? = nil) {

        let resolvedBaseURL =
            baseURL
            ?? documentDir

        guard let baseURL = resolvedBaseURL else {
            logger.error("App dir not found")
            return
        }

        logger.debug("App dir: \(baseURL)")

        let folderURL = baseURL.appendingPathComponent(name)
        if !manager.fileExists(atPath: folderURL.path) {
            do {
                try manager.createDirectory(
                    at: folderURL,
                    withIntermediateDirectories: true
                )
                logger.debug("Folder created at: \(folderURL)")
                //                loadLibrary()
            } catch {
                logger.error("Error creating folder: \(error)")
            }
        } else {
            logger.error("Folder already exists at: \(folderURL)")
        }
    }
}
