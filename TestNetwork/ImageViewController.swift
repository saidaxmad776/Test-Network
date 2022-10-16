//
//  ViewController.swift
//  TestNetwork
//
//  Created by Saidaxmad on 15/10/22.
//

import UIKit

class ImageViewController: UIViewController {

    private let url = """
https://image.winudf.com/v2/image1/Y29tLmJlYXV0aWZ1bC53YWxscGFwZXJzLmFuZC5oZC5iYWNrZ3JvdW5kcy5uYXR1cmVfc2NyZWVuXzBfMTU3NjExODAzNV8wNzM/screen-0.jpg?fakeurl=1&type=.webp
"""
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var downloadLabel: UILabel!
    @IBOutlet weak var activitiyEndigator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitiyEndigator.isHidden = true
        activitiyEndigator.hidesWhenStopped = true
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleToFill
        
        fetchImage()
    }
    
    
    func fetchImage() {
        activitiyEndigator.isHidden = false
        activitiyEndigator.startAnimating()
        
        NetworkManager.downloadImage(url: url) { image in
            self.activitiyEndigator.stopAnimating()
            self.imageView.image = image
        }
    }
    
}

