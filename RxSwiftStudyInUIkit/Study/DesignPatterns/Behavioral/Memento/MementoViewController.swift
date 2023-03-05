//
//  MementoViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class MementoViewController: UIViewController {
    
    private let textView = UITextView().then {
        $0.isEditable = false
        $0.font = .systemFont(ofSize: 24)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(textView)
        
        textView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(24)
        }
        
        textView.text = """
        [ 메멘토 패턴 ]
        - 캡슐화를 유지하면서 객체 내부 상태를 외부에 저장하는 방법
        - 객체 상체를 외부에 저장했다가 해당 상태로 복구할 수 있다.
        
        객체 내부의 상태를 외부에 저장해놓고 저장된 정보를 복원
        일반적으로 내부의 상태를 외부에 저장하려면 객체 상태가 외부에 노출됨
        메멘토를 사용하면 캡슐화를 유지하면서 외부에 디테일하게 객체 내부의 상태를 공개하지 않으면서 외부에 저장
        저장된 데이터로 복원하는 방법
        
        [장점]
        - 스냅샷을 만들 수 있다.
        - 새로운 필드나 정보가 변경되어도 클라이언트 코드가 변경되지 않는다. OCP
        
        [단점]
        - 메모리 사용량에 문제가 있을 수 있음
        
        [사용 예제]
        게임에 대해 저장해놓고 다시 시작할 수 있게 하는 코드
        """
        
        client()
    }
    
    private func client() {
        let game = GameInfo()
        game.setBlueTeamScore(score: 10)
        game.setRedTeamScore(score: 20)
        
        let reGame = GameInfo()
        // 클라 내부 코드를 외부에서 알고 있고
        // 내부 코드가 변경되면 클라코드도 변경해줘야함
        let redTeamScore = game.getRedTeamScore()
        let blueTeamScore = game.getBlueTeamScore()
        reGame.setBlueTeamScore(score: blueTeamScore)
        reGame.setRedTeamScore(score: redTeamScore)
        
        /// Memento
        let mementoGame = GameInfo()
        mementoGame.setBlueTeamScore(score: 10)
        mementoGame.setRedTeamScore(score: 20)
        
        let save = mementoGame.gameSave()
        
        mementoGame.setBlueTeamScore(score: 999)
        mementoGame.setRedTeamScore(score: 111)
        
        mementoGame.restore(gameSave: save)
        
        print(mementoGame.getBlueTeamScore())
        print(mementoGame.getRedTeamScore())
    }
}

class GameInfo {
    
    private var redTeamScore: Int = 0
    private var blueTeamScore: Int = 0
    
    func setBlueTeamScore(score: Int) {
        blueTeamScore = score
    }
    
    func setRedTeamScore(score: Int) {
        redTeamScore = score
    }
    
    func getBlueTeamScore() -> Int {
        return blueTeamScore
    }
    
    func getRedTeamScore() -> Int {
        return redTeamScore
    }
    
    func gameSave() -> GameSave {
        GameSave(redTeamScore: getRedTeamScore(), blueTeamScore: getBlueTeamScore())
    }
    
    func restore(gameSave: GameSave) {
        setRedTeamScore(score: gameSave.getRedTeamScore())
        setBlueTeamScore(score: gameSave.getBlueTeamScore())
    }
}

final class GameSave {
    
    private var redTeamScore: Int = 0
    private var blueTeamScore: Int = 0
    
    init(redTeamScore: Int, blueTeamScore: Int) {
        self.redTeamScore = redTeamScore
        self.blueTeamScore = blueTeamScore
    }
    
    func getBlueTeamScore() -> Int {
        return blueTeamScore
    }
    
    func getRedTeamScore() -> Int {
        return redTeamScore
    }
}
