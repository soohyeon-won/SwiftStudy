//
//  PagingViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2022/08/27.
//

import UIKit
import RxSwift

final class PagingViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
