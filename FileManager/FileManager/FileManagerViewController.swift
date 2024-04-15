//
//  ViewController.swift
//  FileManager
//
//  Created by Ruben Higuera on 09/04/24.
//

import UIKit

class FileManagerViewController: UIViewController, FileManagerViewProtocol {
    var presenter: FileManagerPresenterProtocol?
    let songsArray = ["https://filesamples.com/samples/audio/mp3/SymphonyNo.6(1st movement).mp3",
                      "https://filesamples.com/samples/audio/mp3/sample4.mp3",
                      "https://filesamples.com/samples/audio/mp3/sample3.mp3",
                      "https://filesamples.com/samples/audio/mp3/sample2.mp3",
                      "https://filesamples.com/samples/audio/mp3/sample1.mp3"]
    
    @IBOutlet weak var secondButtonWithConstrain: NSLayoutConstraint!
    @IBOutlet weak var firstButtonWithConstrain: NSLayoutConstraint!
    @IBOutlet weak var firstDwnloadButton: UIButton!
    @IBOutlet weak var secondDownloadButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad {
            firstButtonWithConstrain.constant = 200
            secondButtonWithConstrain.constant = 200
        }else {
            firstButtonWithConstrain.isActive = false
            secondButtonWithConstrain.isActive = false
        }
        
    }
    // Call the action for the presenter to downlad an array of strings
    @IBAction func firstDwnloadButtonAction(_ sender: Any) {
        presenter?.getSongsArray(url: songsArray)
    }
    // Call the action for the presenter to downlad an string multiple times
    @IBAction func secondDownloadButtonAction(_ sender: Any) {
        presenter?.getSong(url:songsArray.first ?? "")
    }
    // Get the success service response
    func serviceSuccessReponse(data: AnyObject?) {
        // Display success alert
        let alert = UIAlertController(title: "Seuccess", message: "Downloads finished correctly", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    // Get the error service response
    func serviceErrorReponse(data: AnyObject?) {
        // Display error alert
        let alert = UIAlertController(title: "Error", message: "Something Went Wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
}
