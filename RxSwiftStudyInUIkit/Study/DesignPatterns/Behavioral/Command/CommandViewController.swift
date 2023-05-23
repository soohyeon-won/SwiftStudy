//
//  CommandViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

import RxSwift

final class CommandViewController: UIViewController {
    
    private let textView = UITextView().then {
        $0.isEditable = false
        $0.font = .systemFont(ofSize: 24)
    }
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        view.addSubview(textView)
        
        textView.snp.makeConstraints{
            $0.edges.equalToSuperview().inset(24)
        }
        
        textView.text = """
        [ 커맨드 패턴 ]
        요청을 캡슐화 하여 호출자(invoker)와 수신자(receiver)를 분리하는 패턴.
        - 요청을 처리하는 방법이 바뀌더라도 호출자의 코드는 변경되지 않는다.
        
        Invoker -> Command(interface) + excute()
                     ⬆️
        receiver <- ConcreateCommand + excute
        
        아래 예제에서는
        invoker / receiver
        Button / Light
        
        [장점]
        1. OCP, SRP
        - 기존 코드를 변경하지 않고 새로운 커맨드 생성 가능
        - 수신자의 코드가 변경되어도 호출자의 코드는 변경되지 않음
        2. command를 다양하게 활용할 수 있음.
        - 예시처럼 Stack으로 활용
        - 커맨드 객체를 로깅, DB에 저장, 네트워크로 전송 하는 등 다양한 방법으로 활용가능
        
        [단점]
        1. 코드가 복잡해 보일 수 있음
        
        [사용 예제]
        client 코드 참고
        
        [전략패턴과의 차이점]
        커맨드 패턴의 예시로는 리모컨을 들 수 있습니다.
        리모컨은 버튼을 누르는 것만으로 TV나 DVD 플레이어 등을 제어할 수 있습니다.
        
        이때 버튼은 요청을 캡슐화한 것입니다.
        전략 패턴의 예시로는 정렬 알고리즘을 들 수 있습니다.
        정렬 알고리즘은 데이터를 정렬하는 방법입니다.
        이때 각각의 정렬 알고리즘은 전략으로 캡슐화됩니다.
        
        커맨드 패턴에서는 객체의 함수를 execute() 함수에서 사용합니다.
        반면 전략 패턴에서는 전략 객체가 자체적으로 sort() 함수를 가지고 있습니다.
        """
        
        client()
    }
    
    private func client() {
        // Command들을 재사용할 수 있는 장점이 있음
        let button = CommandButton(command: LightOnCommand(light: Light()))
        button.press()
        
        let button2 = CommandButton(command: GameStartCommand(game: Game()))
        button2.press()
        
        // Command를 만드는 작업은 늘어나지만
        // Receiver의 코드가 바뀌면 모든 invoker의 코드가 바뀌는 기존 구조와 달리
        // 커맨드 부분만 변경, 추가하면 되어서 변화의 범위가 축소됨
        
        let stackBtn = CommandStackButton()
        stackBtn.press(command: LightOnCommand(light: Light()))
        stackBtn.press(command: GameStartCommand(game: Game()))
        
        stackBtn.undo()
        
        // 만약, 일렬로 이어진 N개의 버튼이 있다고 가정하자.
        // button.rx.tap 으로 버튼의 이벤트를 구독하게 될것이다.
        // 유지보수상 이 버튼의 위치(즉 그에 따른 액션)는 계속 바뀔 수 있다.
        var btnArray = [Command]()
        btnArray.append(WebviewCommand(config: "webview open config"))
        btnArray.append(SafariCommand(config: "safari open config"))
        
        btnArray.forEach {
            let btn = RealCommandButton(command: $0).then {
                $0.backgroundColor = .red
            }
            view.addSubview(btn)
            
            btn.rx.tap
                .subscribe(onNext: {
                    btn.press()
                })
                .disposed(by: disposeBag)
        }
    }
}

struct Light {
    func on() {
        print("불을 켰습니다.")
    }
    
    func off() {
        print("불을 껐습니다.")
    }
}

// JAVA에서의 Runable이라는 인터페이스와 동일한 기능을 제공하기 위해 생성
public protocol Command {
    
    func excute()
    
    func unDo()
}

final class CommandButton {
    
    let command: Command
    
    init(command: Command) {
        self.command = command
    }
    
    func press() {
        command.excute()
    }
}

final class LightOnCommand: Command {
    
    private let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func excute() {
        light.on()
    }
    
    func unDo() {
        light.off()
    }
}

final class LightOffCommand: Command {
    
    private let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func excute() {
        light.off()
    }
    
    func unDo() {
        light.on()
    }
}

struct Game {
    func start() {
        print("게임 시작.")
    }
    
    func end() {
        print("게임 종료.")
    }
}

final class GameStartCommand: Command {
    
    private let game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    func excute() {
        game.start()
    }
    
    func unDo() {
        game.end()
    }
}

// Stack활용

final class CommandStackButton {
    
    var commandStack = [Command]()
    
    func press(command: Command) {
        command.excute()
        commandStack.append(command)
    }
    
    func undo() {
        if !commandStack.isEmpty {
            commandStack.last?.unDo()
            commandStack = commandStack.dropLast()
        }
    }
}

final class RealCommandButton: UIButton {
    
    let command: Command
    
    init(command: Command) {
        self.command = command
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func press() {
        command.excute()
    }
}

final class WebviewCommand: Command {
    
    let config: String
    
    init(config: String) {
        self.config = config
    }
    
    func excute() {
        print("webview open")
    }
    
    func unDo() {
        print("webview close")
    }
}

final class SafariCommand: Command {
    
    let config: String
    
    init(config: String) {
        self.config = config
    }
    
    func excute() {
        print("Safari open")
    }
    
    func unDo() {
        print("Safari close")
    }
}
