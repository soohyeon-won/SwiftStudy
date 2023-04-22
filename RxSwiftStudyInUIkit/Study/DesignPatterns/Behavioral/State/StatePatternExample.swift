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

/*
 상태 패턴과 전략 패턴은 비슷해보이지만 목적이 다릅니다.
 상태 패턴은 객체의 상태에 따라 객체의 행동을 변경하는 패턴입니다.
 예를 들어, 객체가 어떤 상태에 있을 때는 A 메소드를 호출하고, 다른 상태에 있을 때는 B 메소드를 호출하도록 구현할 수 있습니다.
 
 반면 전략 패턴은 알고리즘을 캡슐화하여 동적으로 교체할 수 있도록 만드는 패턴입니다.
 예를 들어, 객체가 어떤 알고리즘을 사용할지는 런타임에 결정될 수 있습니다.
 이러한 차이점으로 인해 상태 패턴은 객체의 상태 변화에 따라 행동을 변경하는 경우에 사용되며, 전략 패턴은 알고리즘을 동적으로 교체해야 하는 경우에 사용됩니다.
 */
