//
//  ImageViewController.swift
//  UrlApp
//
//  Created by Илья Гусаров on 04.06.2022.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchImage()
    }
    
    private func fetchImage() {
        NetworkManager.shared.fetchImage(from: Link.imageURL.rawValue) { result in
            switch result {
            case .success(let image):
                self.imageView.image = UIImage(data: image)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
        
    }
    

}
