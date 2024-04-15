//
//  FileManagerProtocol.swift
//  FileManager
//
//  Created by Ruben Higuera on 09/04/24.
//

import Foundation
import UIKit

protocol FileManagerViewProtocol: AnyObject {
    var presenter: FileManagerPresenterProtocol? {get set}
    
    func serviceSuccessReponse(data: AnyObject?)
    func serviceErrorReponse(data: AnyObject?)
}

protocol FileManagerPresenterProtocol: AnyObject {
    var view: FileManagerViewProtocol? {get set}
    var interactor: FileManagerInteractorInputProtocol? {get set}
    var router: FileManagerRouterProtocol? {get set}

    func getSongsArray(url: [String])
    func getSong(url: String)
}

protocol FileManagerRouterProtocol: AnyObject {
    static func getController() -> UIViewController
}

protocol FileManagerInteractorInputProtocol: AnyObject {
    var presenter: FileManagerInteractorOutputProtocol? {get set}

    func requestSongsArray(url: [String])
    func requestSong(url: String)
}

protocol FileManagerInteractorOutputProtocol: AnyObject {
    func servciceResponse(response: ServerErrors, data: AnyObject?)
    func songDownloadedResponse(response: ServerErrors, nummberDownloads: [Int])
}
