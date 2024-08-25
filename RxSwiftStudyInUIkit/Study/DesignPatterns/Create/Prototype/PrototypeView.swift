//
//  PrototypeViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by soohyeon won on 2023/01/16.
//

import SwiftUI

struct PrototypeView: View {
    
    private let textViewContent = """
        [ 프로토타입 패턴 ]
        기존 인스턴스를 복제하여 새로운 인스턴스를 만드는 방법
        
        복제 기능을 갖추고 있는 기존 인스턴스를 프로토타입으로 사용해 새 인스턴스를 만들 수 있다.
        
        JAVA에서 cloneable을 제공
        shallow copy(얕은 복사) <-> deep(깊은 복사)
        
        swift는 참조타입도 NSCopying 채택하여 deep copy 가능
        
        장점
        복잡한 객체를 만드는 과정을 숨길 수 있다.
        기존 객체를 복제하는 과정이 새 인스턴스를 만드는것보다 비용(시간 or 메모리)적인 면에서 효율적일 수도있다.
        추상적인 타입을 리턴할 수 있다.
        
        단점
        복제한 객체를 만드는 과정 자체가 복잡할 수 있다.(특히, 순환 참조가 있는 경우)
        
        + 추가 개념
        데이터를 저장하기 위해서 포맷을 변경하는 과정
        직렬화(Serializing), 역직렬화(De-Serializing)
        
        직렬화/역직렬화 과정에서 객체는 항상 새로운 객체를 생성한다.
        value type이든 reference type이든 모두 동일하게 깊은 복사를 수행한다.
        
        NSCoding : Archiving과 distribution을 위해 인코딩/디코딩을 가능하게 해주는 프로토콜
        Codable : 외부에서 표현하는 JSON과 같은 데이터 형식으로 인코딩/디코딩을 가능하게 해주는 프로토콜
        """
    
    var body: some View {
        ScrollView {
            Text(textViewContent)
                .font(.system(size: 24))
                .padding(24)
                .background(Color.white)
                .cornerRadius(8)
            
            CodeView(code: """
            struct GithubRepo {
                var issueNumber: Int = 1
            }

            struct GitIssue: Equatable {
                
                var repo: GithubRepo
                
                init(repo: GithubRepo) {
                    self.repo = repo
                }
                static func == (lhs: GitIssue, rhs: GitIssue) -> Bool {
                    lhs.repo.issueNumber == rhs.repo.issueNumber
                }
            }


            class GithubRepository {
                
                var issueNumber: Int = 1
            }

            class GithubIssue: NSCopying {
                
                let repository: GithubRepository
                var actionNumber = 10
                
                init(repository: GithubRepository) {
                    self.repository = repository
                }
                
                func copy(with zone: NSZone? = nil) -> Any {
                    return GithubIssue(repository: GithubRepository())
                }
            }
            
            // 얕은복사 : Shallow copy | 스택영역 | 주소값 복사
            // 깊은복사 : Deep copy | 힙영역 | 실제값을 메모리 값에 복사
            
            // swift는 class로 모델 선언 > clone.repository === githubIssue.repository (true)
            print("=====CLASS=====")
            let repository = GithubRepository()
            let githubIssue = GithubIssue(repository: repository)
            let clone = githubIssue
            print("clone.repository === githubIssue.repository", clone.repository === githubIssue.repository) // true
            print("clone === githubIssue", clone === githubIssue) // true
            
            githubIssue.repository.issueNumber = 2
            print("githubIssue.repository.issueNumber: ", githubIssue.repository.issueNumber)
            print("clone.repository.issueNumber: ", clone.repository.issueNumber)
            
            // struct로 모델 선언 > Equatable채택
            print("=====STRUCT=====")
            var gitIssue = GitIssue(repo: GithubRepo())
            let cloneGitIssue = gitIssue
            
            print("cloneGitIssue === gitIssue", cloneGitIssue == gitIssue)
            
            gitIssue.repo.issueNumber = 20
            print("gitIssue.repo.issueNumber: ", gitIssue.repo.issueNumber)
            print("cloneGitIssue.issueNumber: ", cloneGitIssue.repo.issueNumber)
            
            // 참조타입 NSCopying 채택
            // 깊은복사 가능
            print("=====NSCopying=====")
            guard let clone2 = githubIssue.copy() as? GithubIssue else { return }
            print("clone === clone2", clone === clone2) // false
            
            // 깊은 복사가 이루어졌다.
            githubIssue.actionNumber = 200
            print("githubIssue.actionNumber: ", githubIssue.actionNumber)
            print("clone2.actionNumber: ", clone2.actionNumber)
            
            // 참조 타입 내부에 참조타입을 갖고 있는 경우이기 때문에
            // 아래는 func copy 함수의 내부 구현에 따라 달라짐
            githubIssue.repository.issueNumber = 100
            print("githubIssue.repository.issueNumber: ", githubIssue.repository.issueNumber)
            print("clone.repository.issueNumber: ", clone.repository.issueNumber)
            print("clone2.repository.issueNumber: ", clone2.repository.issueNumber)
            """)
        }
        .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
        .onAppear {
            client()
        }
    }
    
    private func client() {
        // 얕은복사 : Shallow copy | 스택영역 | 주소값 복사
        // 깊은복사 : Deep copy | 힙영역 | 실제값을 메모리 값에 복사
        
        // swift는 class로 모델 선언 > clone.repository === githubIssue.repository (true)
        print("=====CLASS=====") // shallow copy
        let repository = GithubRepository()
        let githubIssue = GithubIssue(repository: repository)
        let clone = githubIssue
        print("clone.repository === githubIssue.repository", clone.repository === githubIssue.repository) // true
        print("clone === githubIssue", clone === githubIssue) // true
        
        githubIssue.repository.issueNumber = 2
        print("githubIssue.repository.issueNumber: ", githubIssue.repository.issueNumber)
        print("clone.repository.issueNumber: ", clone.repository.issueNumber)
        
        // struct로 모델 선언 > Equatable채택
        print("=====STRUCT=====") // deep copy
        var gitIssue = GitIssue(repo: GithubRepo())
        let cloneGitIssue = gitIssue
        
        print("cloneGitIssue === gitIssue", cloneGitIssue == gitIssue) // true
        
        gitIssue.repo.issueNumber = 20
        print("gitIssue.repo.issueNumber: ", gitIssue.repo.issueNumber)
        print("cloneGitIssue.issueNumber: ", cloneGitIssue.repo.issueNumber)
        print("cloneGitIssue === gitIssue", cloneGitIssue == gitIssue) // false
        
        // 참조타입 class에 NSCopying 채택
        // 깊은복사 가능
        print("=====NSCopying=====")
        guard let clone2 = githubIssue.copy() as? GithubIssue else { return }
        print("clone === clone2", clone === clone2) // false
        
        // 깊은 복사가 이루어졌다.
        githubIssue.actionNumber = 200
        print("githubIssue.actionNumber: ", githubIssue.actionNumber)
        print("clone2.actionNumber: ", clone2.actionNumber)
        
        // 참조 타입 내부에 참조타입을 갖고 있는 경우이기 때문에
        // 아래는 func copy 함수의 내부 구현에 따라 달라짐
        print("====참조 타입 내부에 참조타입을 갖고 있는 경우=====")
        githubIssue.repository.issueNumber = 100
        print("githubIssue.repository.issueNumber: ", githubIssue.repository.issueNumber) // 100
        print("clone.repository.issueNumber: ", clone.repository.issueNumber) // 100
        print("clone2.repository.issueNumber: ", clone2.repository.issueNumber) // 1
    }
}
