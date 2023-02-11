//
//  MoyaViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/01/31.
//

import Foundation

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
        
        viewModel.fetch()
    }
}

import Moya
import RxSwift

import DataLayer

final class MoyaViewModel {
    
    let provider: APIProvider<GithubAPI>
    
    init(provider: APIProvider<GithubAPI> = .init()) {
        self.provider = provider
    }
    
    func fetch() {
        provider.request(.emogi) { result in
            print("result: \(result)")
        }
    }
}
