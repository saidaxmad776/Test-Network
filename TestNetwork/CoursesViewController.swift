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
    private var courseName: String?
    private var courseURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.courses = try decoder.decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print("error YES", error)
            }
            
        }.resume()
    }
    
    private func configureCell(cell: CourseTableViewCell, for indexPath: IndexPath) {
        
        let course = courses[indexPath.row]
        cell.courseNameLabel.text = course.name
        
        if let numberOfLessons = course.numberOflessons {
            cell.numberOfLesson.text = "Number Of Lessons: \(numberOfLessons)"
        }
        
        if let numberOfTests = course.numberOftests {
            cell.numberOfTests.text = "Number of tests: \(numberOfTests)"
        }
        
        DispatchQueue.global().async {
            guard let imageUrl = URL(string: course.imageUrl!) else { return }
            guard let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            DispatchQueue.main.async {
                cell.courseImage.image = UIImage(data: imageData)
            }
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let webViewController = segue.destination as! WebViewController
        webViewController.selectedCourse = courseName
        
        if let url = courseURL {
            webViewController.courseURL = url
        }
    }
    
}


extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courses.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CourseTableViewCell
        
        configureCell(cell: cell, for: indexPath)
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let course = courses[indexPath.row]
//        
//        courseURL = course.link
//        courseName = course.name
//        
//        performSegue(withIdentifier: "description", sender: self)
    }
}
