//
//  CourseCell.swift
//  UrlApp
//
//  Created by Илья Гусаров on 07.06.2022.
//

import UIKit

class CourseCell: UITableViewCell {
    @IBOutlet var courseImage: UIImageView!
    @IBOutlet var courseName: UILabel!
    @IBOutlet var courseLessons: UILabel!
    @IBOutlet var courseTests: UILabel!
    
    func configure(with course: Course) {
        courseName.text = course.name
        courseLessons.text = "Number of lessons is: \(course.numberOfLessons ?? 0)"
        courseTests.text = "Number of tests is: \(course.numberOfTests ?? 0)"
        
        NetworkManager.shared.fetchImage(from: course.imageUrl) { result in
            switch result {
            case .success(let imageData):
                self.courseImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configure(with courseV2: CourseV2) {
        courseName.text = courseV2.name
        courseLessons.text = "Number of lessons: \(courseV2.numberOfLessons ?? 0)"
        courseTests.text = "Number of tests: \(courseV2.numberOfTests ?? 0)"
        NetworkManager.shared.fetchImage(from: courseV2.imageUrl) { result in
            switch result {
            case .success(let imageData):
                self.courseImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
