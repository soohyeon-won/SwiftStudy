//
//  CacheEx4View.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 5/15/24.
//

import SwiftUI

struct CacheEx4View: View {
    
    var body: some View {
        ScrollView {
            
            VStack(spacing: 12) {
                VStack {
                    Text("나의 정리")
                        .font(.title)
                        .frame(height: 38)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                    
                    Text("""
                NSCache는 LRU (가장 최근에 엑세스되지 않은 것부터 지우는 캐싱 방법) 를 사용함
                메모리 캐시를 사용하기 때문에 앱구동시 초기화됨
                키-값 쌍으로 저장됨
                FileManager와 함께 이용가능함(디스크캐싱)
                주로 이미지, 네트워크 요청 결과, 쿼리 결과 캐싱등에서 이용
                
                UserDefaults는 디스크에 저장됨
                하지만 앱 시작부터 데이터들을 메모리에 올리고 시작.
                따라서 비교적 작은 데이터들을 사용하는것이 좋음
                """)
                }
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                )
                .padding(.horizontal, 16)
            }
            
            VStack(spacing: 12) {
                VStack {
                    Text("QnA with GPT")
                        .font(.title)
                        .frame(height: 38)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 16)
                    
                    Text("""
                Q1. 내가 만약 채팅에서 공지사항을 저장해야 한다고 했을때, Codable로 생성된 모델을 저장하게 될거임
                채팅방은 여러개가 있고 해당 방에는 하나의 공지사항만 저장될거야.
                서버에 저장하지 않고 디스크에 저장하고 싶을 때
                어떤 방식을 사용하는게 더 좋을까?
                """)
                    .font(.headline)
                    
                    Text("""
A. 단일 공지사항을 여러 채팅 방에 저장하고 싶을 때, 채팅방마다 하나의 공지사항을 유지하는 것이 중요한 부분입니다. 이러한 요구사항을 충족시키기 위해 두 가지 주요 옵션이 있습니다.

UserDefaults 사용: UserDefaults는 앱 내의 간단한 설정이나 상태를 저장하는 데 사용됩니다. 각 채팅 방마다 하나의 UserDefaults 인스턴스를 생성하여 해당 채팅방의 공지사항을 저장할 수 있습니다. 각 채팅방에 대한 키를 사용하여 공지사항을 저장하고 불러올 수 있습니다. 이 방법은 간단하고 빠르게 구현할 수 있으며, 작은 데이터의 경우에는 적합합니다.

파일 시스템 사용: FileManager를 사용하여 디스크에 공지사항을 파일로 저장할 수 있습니다. 각 채팅방마다 파일 하나를 생성하여 해당 채팅방의 공지사항을 저장할 수 있습니다. 이 방법은 좀 더 유연하고 대용량 데이터를 다루기에 적합합니다. Codable을 이용하여 데이터를 파일에 저장하고 불러올 수 있습니다.

두 가지 방법 모두 사용 가능하지만, 데이터의 크기와 구조, 앱의 요구사항에 따라 적합한 방법을 선택하는 것이 중요합니다. 만약 공지사항이 간단하고 용량이 작다면 UserDefaults를 사용하는 것이 간단하고 효율적일 수 있습니다. 그러나 공지사항의 용량이 크거나 구조가 복잡하다면 파일 시스템을 사용하는 것이 더 적합할 수 있습니다.
""")
                }
                
                Text("""
                Q2. 앱이 백그라운드에 들어간 뒤 오랜시간이 지나고 다시 forground로 올라왔을 때
                앱이 재기동 되는것을 막고싶은 개발자라고 했을 때,
                아래 두 방법 중 어떤것이 더 좋음?

                1. 디스크에서 한번 접근해서 가져온 데이터는 NSCache에 저장하고 메모리 캐싱으로 꺼내쓰는 것

                2. 매번 디스크에서 꺼내오기 (FileManager로 접근)
                """)
                .font(.headline)
                
                Text("""
A. 이 상황에서는 매번 디스크에서 꺼내오는 것이 더 적합할 것입니다. 여러 이유로 인해 NSCache를 사용하여 메모리에 데이터를 캐싱하는 것이 재기동을 방지하는 데 효과적이지 않을 수 있습니다.

NSCache는 메모리를 사용하기 때문에 앱이 백그라운드에 들어간 후 오랜 시간이 지나면 메모리가 부족해질 수 있습니다. 이 경우 시스템이 앱을 재기동할 가능성이 높아집니다.
NSCache는 시스템에 의해 제어되는 캐시이기 때문에 언제든지 캐시가 비워질 수 있습니다. 이는 앱이 다시 포그라운드로 돌아왔을 때 NSCache에 저장된 데이터가 없을 수 있다는 것을 의미합니다.
NSCache는 용량이 제한되어 있기 때문에 큰 데이터나 많은 양의 데이터를 저장하기에 적합하지 않을 수 있습니다.
반면에 매번 디스크에서 데이터를 읽어오는 방법은 NSCache를 사용하는 것보다 안정적이고 예측 가능합니다. 디스크에서 데이터를 읽어오는 과정은 시간이 걸릴 수 있지만, 안정성과 데이터의 일관성을 보장할 수 있습니다.
""")
            }
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue.opacity(0.7), lineWidth: 2)
            )
            .padding(.horizontal, 16)
        }
    }
}
