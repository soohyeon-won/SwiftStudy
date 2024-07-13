//
//  PrototypePattern.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 7/10/24.
//

import Foundation

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
