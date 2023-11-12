//
//  SwiftUI-Image.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 11/7/23.
//

import SwiftUI

struct SwiftUI_Image: View {
    var body: some View {
        /// 이미지는 기본적으로 주어진 공간과 관계없이 그 고유의 크기를 유지한다.
        /// 예를 들어 100*100 이미지를 frame수식어로 변경해도 뷰가 차지하는 크기만 달라질 뿐,
        /// 이미지의 크기는 변하지 않는다.
        SafeArea {
            ScrollView {
                VStack {
                    Text("resizable을 이용해서 크기 변환 가능, 순서 중요!")
                    HStack {
                        Image("home")
                            .frame(width: 100, height: 100)
                            .background(.yellow)
                        Spacer()
                        Image("home")
                            .resizable() // Image 타입 반환 수식어
                            .frame(width: 100, height: 100)
                            .background(.yellow)
                    }
                    Spacer()
                    Text("AspectFit : .scaleToFit(), ASpectFill : .scaleToFill()")
                    HStack {
                        /// resizable은 scale to Fill (UIkit: scale to Fill) 비율에 관계없이 주어진 공간을 가득 채운다
                        /// AspectFit : .scaleToFit()
                        /// ASpectFill : .scaleToFill()
                        Image("home")
                            .resizable(capInsets: .init(top: 0, leading: 0, bottom: 0, trailing: 0))
                            .frame(width: 50, height: 50)
                            .background(.yellow)
                        Image("home")
                            .resizable(capInsets: .init(top: 0, leading: 50, bottom: 0, trailing: 0))
                            .frame(width: 50, height: 50)
                            .background(.yellow)
                        Image("home")
                            .resizable()
                            .scaledToFill() // Aspect Fill
                            .frame(width: 100, height: 50)
                            .background(.yellow)
                        Image("home")
                            .resizable()
                            .scaledToFit() // Aspect Fill
                            .frame(width: 100, height: 50)
                            .background(.yellow)
                        
                        /// + 이미 이미지 슬라이싱을 적용해 뒀다면?
                        /// resizable 수식어를 사용하지 않아도 이미 적용된 것과 같이 동작
                    }
                    Spacer()
                    Text("ClipShape")
                    HStack {
                        /// clipShape - 이미지를 원하는 모양으로 만들어준다.
                        /// 지정한 도형의 모습만 남기고 나머지 이미지는 잘라 내는 기능
                        Image("home")
                            .clipShape(
                            Ellipse().path(in: CGRect(x: 20, y: 20, width: 20, height: 20))
                            )
                            .background(.red)
                        Image("home")
                            .background(.red)
                            .clipShape(Circle())
                    }
                    Spacer()
                    Text("RenderingMode")
                    HStack {
                        Image("home").renderingMode(.original)
                        Image("home").renderingMode(.template)
                    }
                    .foregroundColor(.blue)
                }
            }
        }
    }
}

#Preview {
    SwiftUI_Image()
}
