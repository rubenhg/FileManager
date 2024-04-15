//
//  FileManagerRouter.swift
//  FileManager
//
//  Created by Ruben Higuera on 09/04/24.
//

import Foundation
import UIKit

open class FileManagerRouter: FileManagerRouterProtocol {
    
    public static func getController() -> UIViewController {

        let storyboard = UIStoryboard(name: "FileManagerView", bundle: Bundle(for: FileManagerViewController.self))
        let view: FileManagerViewProtocol = storyboard.instantiateViewController(withIdentifier: "FileManagerViewController") as! FileManagerViewController
        let presenter: FileManagerPresenter & FileManagerInteractorOutputProtocol = FileManagerPresenter()
        let interactor: FileManagerInteractorInputProtocol = FileManagerInteractor()
        let router: FileManagerRouterProtocol = FileManagerRouter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view as! UIViewController
    }
}
