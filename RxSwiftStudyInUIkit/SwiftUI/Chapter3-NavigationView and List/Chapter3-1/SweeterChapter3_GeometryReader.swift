//
//  SweeterChapter3_GeometryReader.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 1/1/24.
//

import SwiftUI

/// 지오메트리 리더(Geometry Reader)
/// 자식 뷰에 부모 뷰와 기기에 대한 크기 및 좌표계 정보를 전달하는 컨테이너 뷰
/// init(@ViewBuilder content: @escaping (GeometryProxy) -> Content)
/// 오직 지오메트리 프록시 타입의 정보를 받아 콘텐츠를 정의
/// 최상단(topLeading)기준 배치

struct SweeterChapter3_GeometryReader: View {
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .fill(.red)
                .frame(width: 200, height: 200)
                .overlay(Text("center"))
            VStack {
                Text("SafeAreaInsets").bold()
                Text("top: \(Int(geometry.safeAreaInsets.top))").bold()
                Text("bottom: \(Int(geometry.safeAreaInsets.bottom))").bold()
            }
        }
        
        VStack {
            GeometryReader(content: { g in
                Circle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .overlay(Text("center"))
                Circle()
                    .fill(.purple)
                    .frame(width: 100, height: 100)
                    .overlay(Text("center"))
                Circle()
                    .fill(.blue)
                    .frame(width: 50, height: 50)
                    .overlay(Text("center"))
                Text("topLeading")
                    .foregroundStyle(Color.yellow)
                
                VStack {
                    HStack {
                        Spacer()
                        Text("Local: \(String(describing: g.frame(in: .local).origin))")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("global: \(String(describing: g.frame(in: .global).origin))")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("named: \(String(describing: g.frame(in: .named("HStackCS")).origin))")
                            .coordinateSpace(name: "HStackCS")
                        Spacer()
                    }
                }
            })
        }
        .background(.green)
        
        GeometryReader { geometry in
            Text("Geometry Reader")
                .font(.largeTitle)
                .bold()
                .position(x: geometry.size.width / 2,
                          y: geometry.safeAreaInsets.top)
            
            VStack {
                Text("Size").bold()
                Text("width: \(Int(geometry.size.width))").bold()
                Text("height: \(Int(geometry.size.height))").bold()
            }
            .position(x: geometry.size.width / 2,
                      y: geometry.size.height / 3)
            
            VStack {
                Text("SafeAreaInsets").bold()
                Text("top: \(Int(geometry.safeAreaInsets.top))").bold()
                Text("bottom: \(Int(geometry.safeAreaInsets.bottom))").bold()
            }
            .position(x: geometry.size.width / 2,
                      y: geometry.size.height / 1.5)
        }
    }
}

#Preview {
    SweeterChapter3_GeometryReader()
}
