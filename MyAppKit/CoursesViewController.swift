//
//  CoursesViewController.swift
//  MyAppKit
//
//  Created by Onur Celik on 5.04.2023.
//

import UIKit
public protocol IosAcademyCourses{
    func fetchCoursesName(completion: @escaping ([String])->Void)
}
struct Course: Codable{
    let name: String
}
public class CoursesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var courses =  [Course]()
    let iosAcademyCourses:IosAcademyCourses
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.backgroundColor = .systemBackground
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    public init(iosAcademyCourses:IosAcademyCourses){
        self.iosAcademyCourses = iosAcademyCourses
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        iosAcademyCourses.fetchCoursesName {[weak self] names in
            guard let self = self else {return}
            self.courses = names.map{Course(name: $0)}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }

        
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = courses[indexPath.row].name
        return cell
    }

  

}
