//
//  CoursesViewController.swift
//  TestNetwork
//
//  Created by Saidaxmad on 15/10/22.
//

import UIKit

class CoursesViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private var courses = [Course]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fetchData()
        
    }
    
    func fetchData() {
        
//        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_course"
//        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
//        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
        
        let jsonUrlString = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else { return }
            
            do {
                self.courses = try JSONDecoder().decode([Course].self, from: data)
            } catch let error {
                print("error YES", error)
            }
            
        }.resume()
    }
    
}


extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    

    
    
    
}
