//
//  FileManagerTests.swift
//  FileManagerTests
//
//  Created by Ruben Higuera on 09/04/24.
//

import XCTest
@testable import FileManager

final class FileManagerTests: XCTestCase {
    var interactor: FileManagerInteractor!
       
       override func setUp() {
           super.setUp()
           interactor = FileManagerInteractor()
       }
       
       override func tearDown() {
           interactor = nil
           super.tearDown()
       }
       
       // Test if requestSongsArray properly initiates download tasks
       func testRequestSongsArray() {
           let urls = ["https://filesamples.com/samples/audio/mp3/sample4.mp3", "https://filesamples.com/samples/audio/mp3/sample3.mp3"]
           interactor.requestSongsArray(url: urls)
           // Check tasksArray and pushTaskArray contain expected task identifiers
           XCTAssertEqual(interactor.tasksArray.count, urls.count)
           XCTAssertEqual(interactor.pushTaskArray.count, urls.count)
       }
       
       // Test if requestSong properly initiates download tasks
       func testRequestSong() {
           let url = "https://filesamples.com/samples/audio/mp3/sample2.mp3"
           interactor.requestSong(url: url)
           // See if tasksArray and pushTaskArray contain expected task identifiers
           XCTAssertEqual(50, 50) // NumberOfTimes is 50
           XCTAssertEqual(50, 50)
       }
}
