//
//  StatePatternExample.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/04/22.
//

import Foundation

// 조건: 글 목록에 진입할때 이전에 작성한 글이 없으면 최초 글 작성을 유도한다.
// 상태 protocol 정의, 상태를 갖고있는 class - 상태에 따라 행동

protocol EntryState {
    func entryAction()
}

final class NoWriterEntry: EntryState {
    
    func entryAction() {
        print("글 유도 팝업창 띄움")
    }
}

final class WriterEntry: EntryState {
    
    func entryAction() {
        print("액션 없음")
    }
}

class Community {
    
    var state: EntryState? = nil
    
    func getUseState(isWriter: Bool) {
        if isWriter {
            state = WriterEntry()
        } else {
            state = NoWriterEntry()
        }
    }
    
    func excuteEntryAction() {
        state?.entryAction()
    }
}
