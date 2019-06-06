//
//  ViewController1.swift
//  videoDownload
//
//  Created by iOS Team Lead on 31/05/19.
//  Copyright © 2019 Omega. All rights reserved.
//

import UIKit

class ViewController1: UIViewController, URLSessionDelegate, URLSessionDownloadDelegate
 {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPrintInvoiceClick(_ sender: UIButton) {
        
        guard let url = URL(string: "http://www.kozco.com/tech/organfinale.mp3") else { return }
        
        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        let downloadTask = urlSession.downloadTask(with: url)
        downloadTask.resume()
        
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Download Path:- ", location)
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-hh-mm-ss"
        let result = formatter.string(from: date)
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent + "\(result).mp3")
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileName = "Invoice(\(result)).mp3"
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.copyItem(at: location, to: fileURL)
                print("Destination:- ", fileURL)
                //self.showMyAlert(myMessage: "Your Invoice downloaded successfully.")
                print("file saved")
            } catch {
                print("error saving file:", error)
            }
        }
        
    }
    
    //Download Progress
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("---> Downloaded", totalBytesWritten)
        print("---> Total size of file", totalBytesExpectedToWrite)
    }

}
