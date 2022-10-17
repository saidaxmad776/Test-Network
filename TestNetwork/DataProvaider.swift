//
//  DataProvaider.swift
//  TestNetwork
//
//  Created by Saidaxmad on 17/10/22.
//

import UIKit

class DataProvaider: NSObject {

    private var downloadTask: URLSessionDownloadTask!
    var fileLocation: ((URL) -> ())?
    var onProgres: ((Double) -> ())?
    
    private lazy var bgSession: URLSession = {
        let configure = URLSessionConfiguration.background(withIdentifier: "ru.swiftbook.Networking")
//        configure.isDiscretionary = true
        configure.sessionSendsLaunchEvents = true
        return URLSession(configuration: configure, delegate: self, delegateQueue: nil)
    }()
    
    func startDownload() {
        if let url = URL(string: "https://speed.hetzner.de/100MB.bin") {
            
            downloadTask = bgSession.downloadTask(with: url)
            downloadTask.earliestBeginDate = Date().addingTimeInterval(3)
//            downloadTask.countOfBytesExpectedToSend = 512
//            downloadTask.countOfBytesExpectedToReceive = 100 * 1024 * 1024
            downloadTask.resume()
        }
    }
    
    func stopDownload() {
        downloadTask.cancel()
    }
}


extension DataProvaider: URLSessionDelegate {
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
        DispatchQueue.main.async {
            guard
                let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                let complectionHandler = appDelegate.bgSessionComlectionHandler
            else { return }
            
            appDelegate.bgSessionComlectionHandler = nil
            complectionHandler()
        }
    }
}

extension DataProvaider: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        print("did Download: \(location.absoluteString)")
        
        DispatchQueue.main.async {
            self.fileLocation?(location)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        guard totalBytesExpectedToWrite != NSURLSessionTransferSizeUnknown else { return }
        
        let progress = Double(totalBytesWritten / totalBytesExpectedToWrite)
        print("Download Progre: \(progress)")
        
        DispatchQueue.main.async {
            self.onProgres?(progress)
        }
    }
}
