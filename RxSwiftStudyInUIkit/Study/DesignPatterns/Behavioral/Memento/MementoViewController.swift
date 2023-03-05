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
        Swift 표준 라이브러리에서는 메멘토 패턴과 관련된 기능을 제공하지는 않습니다.
        그러나 다음과 같은 Swift 라이브러리 및 프레임워크에서 메멘토 패턴을 구현하고 사용할 수 있습니다.

        1. Core Data
        Apple에서 제공하는 데이터 저장 및 관리 프레임워크인 Core Data에서는 객체 그래프의 상태를 저장하고 복원하는 기능을 제공합니다.
        이를 위해 NSManagedObject 클래스에서 NSManagedObjectContext를 사용하여 메멘토 패턴을 구현합니다.

        2. Realm
        Realm은 데이터베이스 및 객체 스토리지 솔루션으로,
        객체의 상태를 저장하고 복원하는 메서드를 제공합니다.
        이를 통해 메멘토 패턴을 구현할 수 있습니다.

        3. Codable
        Swift 4 이상에서는 Codable 프로토콜을 통해 객체의 인코딩 및 디코딩을 지원합니다.
        이를 사용하여 객체의 상태를 JSON 또는 다른 형식으로 인코딩하고, 필요할 때 디코딩하여 상태를 복원할 수 있습니다.
        이 방식은 메멘토 패턴과 유사한 기능을 제공합니다.

        4. UserDefaults
        UserDefaults는 간단한 값 저장소로, 객체의 일부 상태를 저장하고 복원할 수 있습니다.
        이를 사용하여 객체의 상태를 저장하고, 필요할 때 불러와 상태를 복원할 수 있습니다.
        이 방식은 메멘토 패턴과 유사한 기능을 제공합니다.

        위에서 언급한 라이브러리와 프레임워크는 메멘토 패턴을 구현하는 방법을 제공하지만,
        메멘토 패턴은 일반적으로 객체의 상태를 저장하고 복원하는 고급 기술입니다.
        따라서 개발자가 직접 구현하는 경우가 더 많습니다.
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
