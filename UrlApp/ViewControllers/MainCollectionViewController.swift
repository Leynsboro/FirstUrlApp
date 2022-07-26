//
//  MainCollectionViewController.swift
//  UrlApp
//
//  Created by Илья Гусаров on 04.06.2022.
//

import UIKit

enum Link: String {
    case imageURL = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    case exampleOne = "https://swiftbook.ru//wp-content/uploads/api/api_course"
    case exampleTwo = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    case exampleThree = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
    case exampleFour = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
    case exampleFive = "https://swiftbook.ru//wp-content/uploads/api/api_courses_capital"
    case postRequest = "https://jsonplaceholder.typicode.com/posts"
    case courseImageURL = "https://swiftbook.ru/wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png"
}

enum UserAction: String, CaseIterable {
    case downloadImage = "Download Image"
    case exampleOne = "Example One"
    case exampleTwo = "Example Two"
    case exampleThree = "Example Three"
    case exampleFour = "Example Four"
    case ourCourses = "Our Courses"
    case ourCoursesV2 = "Capital to Lowcase"
    case postRequestWithDict = "POST RQST with Dict"
    case postRequestWithModel = "POST RQST with Model"
    case alamofireGet = "Alamofire GET"
    case alamofirePost = "Alamofire POST"
}

class MainCollectionViewController: UICollectionViewController {
    
    let userActions = UserAction.allCases
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collection", for: indexPath) as! UserActionCell
    
        cell.userActionLabel.text = userActions[indexPath.item].rawValue
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .downloadImage: performSegue(withIdentifier: "showImage", sender: nil)
        case .exampleOne: exampleOneButtonPressed()
        case .exampleTwo: exampleTwoButtonPressed()
        case .exampleThree: exampleThreeButtonPressed()
        case .exampleFour: exampleFourButtonPressed()
        case .ourCourses: performSegue(withIdentifier: "showCourses", sender: nil)
        case .ourCoursesV2: performSegue(withIdentifier: "showCoursesV2", sender: nil)
        case .postRequestWithDict: postRequestWithDict()
        case .postRequestWithModel: postRequestWithModel()
        case .alamofireGet: performSegue(withIdentifier: "alamofireGet", sender: nil)
        case .alamofirePost: performSegue(withIdentifier: "alamofirePost", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "showImage" {
            guard let coursesVC = segue.destination as? CoursesViewController else { return }
            switch segue.identifier {
            case "showCourses": coursesVC.fetchCourses()
            case "showCoursesV2": coursesVC.fetchCoursesV2()
            case "alamofireGet": coursesVC.alamofireGet()
            case "alamofirePost": coursesVC.alamofirePost()
            default: break
            }
        }
    }

}

extension MainCollectionViewController {
    private func successAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Success",
                message: "Connection is good",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "Connection is failed",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}

extension MainCollectionViewController {
    private func exampleOneButtonPressed() {
        NetworkManager.shared.fetch(dataType: Course.self, url: Link.exampleOne.rawValue) { result in
            switch result {
            case .success(let course):
                self.successAlert()
                print(course)
            case .failure(let error):
                print(error)
                self.failedAlert()
            }
        }
    }
    
    private func exampleTwoButtonPressed() {
        NetworkManager.shared.fetch(dataType: [Course].self, url: Link.exampleTwo.rawValue) { result in
            switch result {
            case .success(let course):
                self.successAlert()
                print(course)
            case .failure(let error):
                self.failedAlert()
                print(error)
            }
        }
    }
    
    private func exampleThreeButtonPressed() {
        NetworkManager.shared.fetch(dataType: WebsiteDescription.self, url: Link.exampleThree.rawValue) { result in
            switch result {
            case .success(let desc):
                self.successAlert()
                print(desc)
            case .failure(let error):
                self.failedAlert()
                print(error)
            }
        }
    }
    
    private func exampleFourButtonPressed() {
        NetworkManager.shared.fetch(dataType: WebsiteDescription.self, url: Link.exampleFour.rawValue) { result in
            switch result {
            case .success(let desc):
                self.successAlert()
                print(desc)
            case .failure(let error):
                self.failedAlert()
                print(error)
            }
        }
    }
    
    private func postRequestWithDict() {
        let course =
        [
            "name": "IOs learning",
            "numberOfTests": "20",
            "stars": "5"
        ]
        NetworkManager.shared.postRequest(with: course, url: Link.postRequest.rawValue) { result in
            switch result {
            case .success(let course):
                self.successAlert()
                print(course)
            case .failure(let error):
                self.failedAlert()
                print(error)
            }
        }
    }
    
    private func postRequestWithModel() {
        let course = CourseV3(name: "Networking", imageUrl: "imgurl", numberOfLessons: "15", numberOfTest: "1")
        NetworkManager.shared.postRequestWithModel(with: course, url: Link.postRequest.rawValue) { result in
            switch result {
            case .success(let course):
                self.successAlert()
                print(course)
            case .failure(let error):
                self.failedAlert()
                print(error)
            }
        }
    }
}

extension MainCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 40, height: 100)
    }
}
