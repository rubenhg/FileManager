//
//  FileManagerPushTest.swift
//  FileManagerTests
//
//  Created by Ruben Higuera on 14/04/24.
//

import XCTest

class FileManagerPushTest: XCTestCase {
    
    func testSongDownloadedResponse() {
        // Given
        let serverError = ServerErrors.someError
        let downloadNumbers = [1, 2, 3]
        let expectation = XCTestExpectation(description: "Push notifications sent")
        
        // When
        songDownloadedResponse(response: serverError, nummberDownloads: downloadNumbers)
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            expectation.fulfill()
        }
        
        // Wait for expectations
        wait(for: [expectation], timeout: 5)
    }
}

enum ServerErrors {
    case someError
}

class PushNotification {
    func sendPushNotification(downloadNumber: Int) {

    }
}

func songDownloadedResponse(response: ServerErrors, nummberDownloads: [Int]) {
    let pushArray = nummberDownloads
    for i in pushArray {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            PushNotification().sendPushNotification(downloadNumber: i)
        })
    }
}
