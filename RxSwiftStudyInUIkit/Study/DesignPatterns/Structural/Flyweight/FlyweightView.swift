//
//  FlyweightView.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/11.
//

import SwiftUI

struct FlyweightView: View {
    
    private let textViewContent: String = """
        [ 플라이웨이트 패턴 ]
        자주 변하는 속성(또는 외적인 속성 extrinsic)과 변하지 않는 속성(또는 내적인 속성, intrinsic)을 분리하고 재사용하여 메모리 사용을 줄일 수 있다.
        다른 객체들이 공통으로 사용하는 데이터를 캐싱하여 RAM을 절약합니다.
        
        성능을 개선하는 패턴
        자주 변하지 않는 속성을 재사용하여 사용
        extrinsic(외적, 자주변하는것, 본질적이지 않은것) <-> intrinsic(내적, 변하지않는것, 본질적인 것)
        FliweightFactory
        Fliyweight
        
        [장점]
        어플리케이션에서 사용하는 메모리를 줄일 수 있다.
        
        [단점]
        코드의 복잡도가 증가한다.
        
        [사용예시]
        1. java Integer valueOf(int i)
        자주사용되는 범위에 있는 값들을 캐싱하여 리턴해준다.
        자바에서 int1 == int2 보다 isEqual 사용을 권장하는 이유
        """
    
    var body: some View {
        VStack {
            ScrollView {
                Text(textViewContent)
                    .font(.system(size: 24))
                    .padding(24)
                    .background(Color.white)
                    .cornerRadius(8)
                
                CodeView(code: """
                let fontFactory = FontFactory()
                // 아래처럼 여러번 재사용될때 메모리 사용을 줄일 수 있음
                // 이때 Intrinsic 속성을 모아놓은 클래스는 다른 곳들에서 공유하는 클래스이기때문에 Immutable해야함
                // ex1. 폰트
                let _ = Characters(
                    value: "h",
                    color: "white",
                    font: fontFactory.getFont(font: Font(family: "nanum", size: 12.0))
                )
                
                // ex2. 웹 브라우저: DOM 노드 관리
                let styleFactory = StyleFlyweightFactory()

                let style1 = styleFactory.getFlyweight(color: "red", fontSize: 12)
                let style2 = styleFactory.getFlyweight(color: "red", fontSize: 12)

                style1.apply(to: "div1")
                style2.apply(to: "div2")
                """)
            }
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .onAppear {
                client()
            }
        }
    }
    
    private func client() {
        let fontFactory = FontFactory()
        // 아래처럼 여러번 재사용될때 메모리 사용을 줄일 수 있음
        // 이때 Intrinsic 속성을 모아놓은 클래스는 다른 곳들에서 공유하는 클래스이기때문에 Immutable해야함
        let _ = Characters(
            value: "h",
            color: "white",
            font: fontFactory.getFont(font: Font(family: "nanum", size: 12.0))
        )
        
        let styleFactory = StyleFlyweightFactory()

        let style1 = styleFactory.getFlyweight(color: "red", fontSize: 12)
        let style2 = styleFactory.getFlyweight(color: "red", fontSize: 12)

        style1.apply(to: "div1")
        style2.apply(to: "div2")
    }
}

class Characters {
    let value: Character
    let color: String
    let font: Font
    
    init(value: Character, color: String, font: Font) {
        self.value = value
        self.color = color
        self.font = font
    }
}

// Intrinsic, Immutable
// 누군가가 받아서 데이터를 변경하지 못하게함
// 다른 여러 클래스에서 공유되는 클래스이기 때문
final class Font {
    final let family: String
    final let size: CGFloat
    
    init(family: String, size: CGFloat) {
        self.family = family
        self.size = size
    }
    
    func getFamily() -> String {
        family
    }
    
    func getSize() -> CGFloat {
        size
    }
}

// FlyweightFactory
class FontFactory {
    var cache = [String:Font]()
    
    init(cache: [String : Font] = [String:Font]()) {
        self.cache = cache
    }
    
    func getFont(font: Font) -> Font {
        if let beforeValue = cache.updateValue(font, forKey: font.getFamily()) {
            return beforeValue
        }
        cache[font.getFamily()] = font
        return font
    }
}

class StyleFlyweight {
    let color: String
    let fontSize: Int

    init(color: String, fontSize: Int) {
        self.color = color
        self.fontSize = fontSize
    }

    func apply(to element: String) {
        print("Applying color: \(color), fontSize: \(fontSize) to \(element)")
    }
}

class StyleFlyweightFactory {
    private var flyweights: [String: StyleFlyweight] = [:]

    func getFlyweight(color: String, fontSize: Int) -> StyleFlyweight {
        let key = "\(color)-\(fontSize)"
        if let flyweight = flyweights[key] {
            return flyweight
        } else {
            let flyweight = StyleFlyweight(color: color, fontSize: fontSize)
            flyweights[key] = flyweight
            return flyweight
        }
    }
}
