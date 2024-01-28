//
//  MoyaViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/01/31.
//

import UIKit

final class MoyaViewController: UIViewController {
    
    let viewModel: MoyaViewModel
    
    init(viewModel: MoyaViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
    }
}

struct GithubModel: Codable {
    
}
