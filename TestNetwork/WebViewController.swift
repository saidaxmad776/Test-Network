//
//  WebViewController.swift
//  TestNetwork
//
//  Created by Saidaxmad on 16/10/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var selectedCourse: String?
    var courseURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedCourse
        
        guard let url = URL(string: courseURL) else { return }
        let request = URLRequest(url: url)
    }
    
    
}
