//
//  FileManagerInteractor.swift
//  FileManager
//
//  Created by Ruben Higuera on 09/04/24.
//

import Foundation
// Handle server errors
enum ServerErrors: Error {
    case InternalError
    case ServerError
    case Ok
}
// This class manage the call to the server and dawnloads the images
class FileManagerInteractor: NSObject, FileManagerInteractorInputProtocol {
    
    var presenter: FileManagerInteractorOutputProtocol?
    var tasksArray: [Int] = []
    var pushTaskArray: [Int] = []
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.background(withIdentifier: "com.filemanager.MySessionBackground")
        config.isDiscretionary = true
        config.sessionSendsLaunchEvents = true
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    func requestSongsArray(url: [String]) {
        for urlString in url {
            guard let safeUrl = URL(string: urlString) else {return}
            let task = self.urlSession.downloadTask(with: safeUrl)
            self.tasksArray.append(task.taskIdentifier)
            self.pushTaskArray.append(task.taskIdentifier)
            task.resume()
        }
    }
    
    func requestSong(url: String) {
        let downloadGroup = DispatchGroup()
        let downloadQueue = DispatchQueue(label: "com.filemanager.downloadQueue", attributes: .concurrent)
        let numberOfTimes = 50
        let simultaneousDownloads = 5
        for _ in 0..<numberOfTimes {
            downloadGroup.enter()
            downloadQueue.async(group: downloadGroup) {
                let semaphore = DispatchSemaphore(value: simultaneousDownloads)
                semaphore.wait()
                guard let safeUrl = URL(string: url) else {return}
                let task = self.urlSession.downloadTask(with: safeUrl)
                self.tasksArray.append(task.taskIdentifier)
                self.pushTaskArray.append(task.taskIdentifier)
                defer {
                    semaphore.signal()
                    downloadGroup.leave()
                }
                task.resume()
            }
        }
    }
    
    fileprivate func getUniqueFileName(from originalFileName: String) -> String {
        let uuid = UUID().uuidString.prefix(3) // Shorten UUID to 3 characters
        let fileExtension = (originalFileName as NSString).pathExtension
        let fileNameWithoutExtension = (originalFileName as NSString).deletingPathExtension
        let uniqueFileName = "\(fileNameWithoutExtension)_\(uuid).\(fileExtension)"
        return uniqueFileName
    }
}

extension FileManagerInteractor: URLSessionDownloadDelegate {
    
   public func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            let manager = FileManager.default
            let destinationURL = try manager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(getUniqueFileName(from: downloadTask.originalRequest!.url!.lastPathComponent))
            try? manager.removeItem(at: destinationURL)
            try manager.moveItem(at: location, to: destinationURL)
            print(destinationURL)
        } catch {
            print(error)
        }
        // Keeps track of the requests and updates tasksArray
        if let index = self.tasksArray.firstIndex(of: downloadTask.taskIdentifier) {
            self.tasksArray.remove(at: index)
            print(self.tasksArray.count)
        }
        
        DispatchQueue.main.async() {
            if self.tasksArray.count == 0 {
                self.presenter?.songDownloadedResponse(response: ServerErrors.Ok, nummberDownloads: self.pushTaskArray)
                if (downloadTask.error != nil) {
                    self.presenter?.servciceResponse(response: ServerErrors.ServerError, data: nil)
                }
                self.presenter?.servciceResponse(response: ServerErrors.Ok, data: nil)
                self.pushTaskArray = []
            }
        }
    }
}
