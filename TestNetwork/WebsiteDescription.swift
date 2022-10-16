//
//  WebsiteDescription.swift
//  TestNetwork
//
//  Created by Saidaxmad on 16/10/22.
//

import Foundation

struct WebsiteDescription: Decodable {
    
    let websiteDescription: String?
    let websiteName: String?
    let courses: [Course]?
}
