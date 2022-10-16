//
//  CourseModel.swift
//  TestNetwork
//
//  Created by Saidaxmad on 15/10/22.
//

import Foundation

struct Course: Decodable {
    
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let number_of_lessons: Int?
    let number_of_tests: Int?
}
