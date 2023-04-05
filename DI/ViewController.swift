//
//  ViewController.swift
//  DI
//
//  Created by Onur Celik on 5.04.2023.
//

import UIKit
import APIKit
import MyAppKit

extension  APICaller: IosAcademyCourses{}

class ViewController: UIViewController {
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("Tap Me", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect(x: view.center.x-125, y: view.center.y-25, width: 250, height: 50)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    @objc func didTapButton(){
        let vc = CoursesViewController(iosAcademyCourses: APICaller.shared)
        present(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
    }


}

