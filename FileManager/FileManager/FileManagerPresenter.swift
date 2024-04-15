//
//  FileManagerPresenter.swift
//  FileManager
//
//  Created by Ruben Higuera on 09/04/24.
//

import Foundation
// This class manages the conection between the view and interactor
class FileManagerPresenter: FileManagerPresenterProtocol, FileManagerInteractorOutputProtocol {
    
    var view: FileManagerViewProtocol?
    
    var interactor: FileManagerInteractorInputProtocol?
    
    var router: FileManagerRouterProtocol?
    // Call the service
    func getSongsArray(url: [String]) {
        interactor?.requestSongsArray(url: url)
    }
    
    func getSong(url: String) {
        interactor?.requestSong(url: url)
    }
    // Get reponse form server and bring data down to the view
    func servciceResponse(response: ServerErrors, data: AnyObject?) {
        switch response {
        case .InternalError:
            view?.serviceErrorReponse(data: data)
        case .ServerError:
            view?.serviceErrorReponse(data: data)
        case .Ok:
            view?.serviceSuccessReponse(data: data)
        }
    }
    // Pushnotification
    func songDownloadedResponse(response: ServerErrors, nummberDownloads: [Int]) {
        let pushArray = nummberDownloads
        for i in pushArray {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                PushNotification().sendPushNotification(downloadNumber: i)
            })
        }
    }
}
