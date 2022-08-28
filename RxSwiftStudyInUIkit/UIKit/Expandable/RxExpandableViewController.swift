//
//  ExpandableTableViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2022/08/27.
//

import UIKit
import RxSwift
import RxRelay

final class RxExpandableViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var data = SectionList()
    private var rxData = PublishRelay<SectionList>()
    
    private lazy var tableView = UITableView(
        frame: .zero, style: .grouped
    ).then {
        $0.bounces = false
        $0.separatorStyle = .none
        $0.rowHeight = 40
        $0.sectionHeaderHeight = 22
        $0.sectionFooterHeight = 0
        $0.delegate = self
        $0.dataSource = self
        $0.register(BaseTextTableViewCell.self)
    }
    var hiddenSections = Set<Int>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setupUI()
        setupData()
    }
    
    func setupData() {
        for i in 0..<100 {
            var rowList = [SectionList.Section.Data]()
            for j in 0..<2 {
                rowList.append(SectionList.Section.Data(rowTitle: "row \(j)"))
            }
            data.list.append(SectionList.Section(title: "section \(i)", rowList: rowList))
        }
        
        rxData.accept(data)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bindOutput() {
        
    }
    
}

extension RxExpandableViewController: UITableViewDelegate {
    
}

extension RxExpandableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = BaseTextTableViewCell()
        cell.label.text = data.list[indexPath.section].rowList[indexPath.row].rowTitle
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.list.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 섹션이 hidden이므로 행을 노출시키지 않는다.
        if hiddenSections.contains(section) {
            return 0
        }
        
        // 가진 데이터의 개수만큼 노출시킨다.
        return data.list[section].rowList.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // UIButton 생성
        let sectionButton = UIButton()
        
        // section 제목
        sectionButton.setTitle(String(section),
                               for: .normal)
        
        // section 배경 색
        sectionButton.backgroundColor = .systemBlue
        
        // tag로 섹션을 구분할 것이다.
        sectionButton.tag = section
        
        // section을 터치했을 때 실행할 메서드 설정(밑에서 구현한다.)
        sectionButton.addTarget(self,
                                action: #selector(self.hideSection(sender:)),
                                for: .touchUpInside)

        return sectionButton
    }
    
    @objc
    private func hideSection(sender: UIButton) {
        // section의 tag 정보를 가져와서 어느 섹션인지 구분한다.
        let section = sender.tag
        
        // 특정 섹션에 속한 행들의 IndexPath들을 리턴하는 메서드
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<data.list[section].rowList.count {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            
            return indexPaths
        }
        
        // 가져온 section이 원래 감춰져 있었다면
        if self.hiddenSections.contains(section) {
            // section을 다시 노출시킨다.
            self.hiddenSections.remove(section)
            self.tableView.insertRows(at: indexPathsForSection(),
                                      with: .fade)
        } else {
            // section이 원래 노출되어 있었다면 행들을 감춘다.
            self.hiddenSections.insert(section)
            self.tableView.deleteRows(at: indexPathsForSection(),
                                      with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
