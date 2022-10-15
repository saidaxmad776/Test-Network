//
//  ViewController.swift
//  TestNetwork
//
//  Created by Saidaxmad on 15/10/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var downloadLabel: UILabel!
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var activitiyEndigator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activitiyEndigator.isHidden = true
        activitiyEndigator.hidesWhenStopped = true
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleToFill
        tapButton.layer.cornerRadius = 10
        
    }
    
    
    @IBAction func getImageTap(_ sender: UIButton) {
        
        activitiyEndigator.isHidden = false
        activitiyEndigator.startAnimating()
        
        // Это его URL
        guard let url = URL(string: "https://image.winudf.com/v2/image1/Y29tLmJlYXV0aWZ1bC53YWxscGFwZXJzLmFuZC5oZC5iYWNrZ3JvdW5kcy5uYXR1cmVfc2NyZWVuXzBfMTU3NjExODAzNV8wNzM/screen-0.jpg?fakeurl=1&type=.webp") else { return }
        
        // Экземпляр URLSession
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.activitiyEndigator.stopAnimating()
                    self.imageView.image = image
                }
            }
        }.resume()
    }
    
}

