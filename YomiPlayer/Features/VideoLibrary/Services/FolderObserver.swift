//
//  FolderObserver.swift
//  YomiPlayer
//
//  Created by Kuanysh Yabekov on 26.07.2025.
//

import Foundation

class FolderObserver: NSObject, NSFilePresenter {
    var presentedItemURL: URL?
    var presentedItemOperationQueue: OperationQueue

    var onChange: (() -> Void)?

    init(folderURL: URL) {
        self.presentedItemURL = folderURL
        self.presentedItemOperationQueue = OperationQueue()
        super.init()

        // Регистрируем наблюдателя у NSFileCoordinator
        NSFileCoordinator.addFilePresenter(self)
    }

    deinit {
        NSFileCoordinator.removeFilePresenter(self)
    }

    // Этот метод вызывается, когда что-то меняется в папке
    func presentedSubitemDidChange(at url: URL) {
        print("Changed: \(url)")
        onChange?()
    }

    // Этот метод вызывается, если файл удалён
    func presentedItemDidDisappear() {
        print("Directory disappeared")
        onChange?()
    }

    // Этот вызывается, если папку переместили
    func presentedItemDidMove(to newURL: URL) {
        print("Directory moved to: \(newURL)")
    }
}
