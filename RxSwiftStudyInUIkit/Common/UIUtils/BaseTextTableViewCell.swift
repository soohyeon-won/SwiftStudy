//
//  BaseTextTableViewCell.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2022/08/28.
//

import UIKit

final class BaseTextTableViewCell: UITableViewCell {
    
    let label = UILabel().then {
        $0.textColor = .black
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    func setupUI() {
        contentView.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
