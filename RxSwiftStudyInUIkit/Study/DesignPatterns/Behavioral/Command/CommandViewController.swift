//
//  CommandViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import UIKit

final class CommandViewController: UIViewController {
    
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
        
        [단점]
        
        [사용 예제]
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
    }
}

final class Button {
    private let light: Light
    
    public init(light: Light) {
        self.light = light
    }
    
    func press() {
        light.off()
    }
    
}

struct Light {
    func on() {
        
    }
    
    func off() {
        
    }
}

// JAVA에서의 Runable이라는 인터페이스와 동일한 기능을 제공하기 위해 생성
public protocol Command {
    
    func excute()
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
}

final class LightOffCommand: Command {
    
    private let light: Light
    
    init(light: Light) {
        self.light = light
    }
    
    func excute() {
        light.off()
    }
}

struct Game {
            func start() {
                
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
}

