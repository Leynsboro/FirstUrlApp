//
//  CoursesViewController.swift
//  UrlApp
//
//  Created by Илья Гусаров on 07.06.2022.
//

import UIKit

class CoursesViewController: UITableViewController {
    
    var courses: [Course] = []
    var coursesV2: [CourseV2] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.isEmpty ? coursesV2.count : courses.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! CourseCell
    
        if courses.isEmpty {
            let courseV2 = coursesV2[indexPath.row]
            cell.configure(with: courseV2)
        } else {
            let course = courses[indexPath.row]
            cell.configure(with: course)
        }
        
        return cell
    }
}

extension CoursesViewController {
    func fetchCourses() {
        NetworkManager.shared.fetch(dataType: [Course].self, url: Link.exampleTwo.rawValue) { result in
            switch result {
            case .success(let courses):
                self.courses = courses
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchCoursesV2() {
        NetworkManager.shared.fetch(dataType: [CourseV2].self, url: Link.exampleFive.rawValue, fromSnakeToCamle: false) { result in
            switch result {
            case .success(let courses):
                self.coursesV2 = courses
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func alamofireGet() {
        NetworkManager.shared.fetchDataWithAlamofire(Link.exampleFive.rawValue) { result in
            switch result {
            case .success(let courses):
                self.coursesV2 = courses
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func alamofirePost() {
        let course = CourseV3(name: "asfaf", imageUrl: "afsaf", numberOfLessons: "asfasf", numberOfTest: "asfasf")
        NetworkManager.shared.postDataWithAlamofire(Link.postRequest.rawValue, data: course) { result in
            switch result {
            case .success(let course):
                print(course)
            case .failure(let error):
                print(error)
            }
        }
    }
}
