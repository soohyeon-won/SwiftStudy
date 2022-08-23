//
//  ViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2022/08/21.
//

import UIKit
import SnapKit
import Then
import RxSwift

class ViewController: UIViewController {
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
