//
//  IteratorViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/19.
//

import SwiftUI

struct IteratorView: View {
    
    private let textViewContent: String = """
        [ 이터레이터(반복자) 패턴 ]
        - 집합객체를 순회하는 패턴, 내부 구조를 노출하지 않고 순회하는 방법을 제공
        
        [구조도]
        Iterator(interface) <- client -> Aggregate(interface)
                ↑                                 ↑
        ConcreteIterator    <- ------- -> ConcreateAggregate
        
        [장점]
        - 집합 객체를 순회하는 클라이언트 코드를 변경하지 않고 다양한 순회 방법을 제공할 수 있다.
        - 집합 객체가 가지고 있는 객체들에 손쉽게 접근할 수 있다.
        - 일관된 인터페이스를 사용해 여러 형태의 집합 구조를 순회할 수 있다.
        - 클래스 내부에 어떻게 선언되어있는지(Set? Array? dic?) 상관없이 next함수만을 가지고 순회를 할 수 있음 // SRP
        - 내부 구조(list)가 변경이 될 수 있는 가능성이 있으면 Iterator를 사용하면 client코드의 변경없이 수정할 수 있음.
        
        [단점]
        - 클래스가 늘어나고 복잡도가 증가한다.
        
        [사용 예제]
        1. JAVA Enumeration, Iterator
        2. JAVA StAX(Streaming API for XML)의 Iterator 기반 API
        - XmlEventReader, XmlEventWriter
        3. Spring - CompositeIterator
                
        [for문과 비교]
        1. 복잡한 컬렉션을 순회해야 할 때
          - 컬렉션이 다양한 자료형이나 구조로 이루어져 있을 때, 이터레이터 패턴을 사용하면 일관된 방식으로 접근할 수 있습니다.
        2. 내부 구현을 숨기면서 데이터를 순회하고자 할 때
          - 이터레이터는 컬렉션의 내부 구조를 노출하지 않고도 외부에서 데이터를 처리할 수 있게 해줍니다.
        3. 동일한 접근 방식을 유지하고 싶을 때
          - 여러 종류의 데이터 구조를 통일된 방식으로 순회하고자 할 때 유용합니다.
        
        이터레이터 패턴이 단순한 for 문보다 더 유리한 경우는 복잡한 데이터 구조를 다룰 때와 확장성이 중요한 상황에서입니다. 
        단순한 컬렉션을 다룰 때는 for 문을 사용하는 것이 간결하고 빠르지만, 아래의 상황에서는 이터레이터 패턴이 훨씬 효과적일 수 있습니다.
        
        순회 방식을 유연하게 변경할 수 있습니다. 정방향, 역방향, 필터링된 순회 등 다양한 방식의 탐색을 쉽게 적용할 수 있습니다.
        ex) 역방향 음악 재생, 랜덤 재생

        이터레이터 패턴은 다음과 같은 상황에서 for 문보다 더 좋은 선택이 될 수 있습니다:

        복잡한 데이터 구조를 다루는 경우 (예: 트리, 그래프)
        다양한 순회 방식을 제공해야 하는 경우 (예: 정방향, 역방향, 랜덤 등)
        데이터를 유연하게 부분적으로 순회하거나 중단할 필요가 있는 경우
        내부 구조를 감추고 추상화하여 데이터를 순회하고자 할 때
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
                // 노래(Song) 클래스 정의
                struct Song {
                    let title: String
                    let artist: String
                }

                // 노래 이터레이터 프로토콜 정의
                protocol SongIterator {
                    func next() -> Song?
                    var hasNext: Bool { get }
                }

                // 재생 목록(Playlist) 클래스
                class Playlist {
                    private var songs: [Song] = []
                    
                    func addSong(_ song: Song) {
                        songs.append(song)
                    }
                    
                    func makeIterator() -> SongIterator {
                        return PlaylistIterator(songs)
                    }
                }

                // 재생 목록 이터레이터 구현
                class PlaylistIterator: SongIterator {
                    private var current = 0
                    private let songs: [Song]
                    
                    init(_ songs: [Song]) {
                        self.songs = songs
                    }
                    
                    var hasNext: Bool {
                        return current < songs.count
                    }
                    
                    func next() -> Song? {
                        guard hasNext else { return nil }
                        let song = songs[current]
                        current += 1
                        return song
                    }
                }
                
                class RandomPlaylistIterator: SongIterator {
                    private var songs: [Song]
                    
                    init(_ songs: [Song]) {
                        self.songs = songs.shuffled()  // 랜덤으로 셔플
                    }
                    
                    private var current = 0
                    
                    var hasNext: Bool {
                        return current < songs.count
                    }
                    
                    func next() -> Song? {
                        guard hasNext else { return nil }
                        let song = songs[current]
                        current += 1
                        return song
                    }
                }
                """)
            }
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .onAppear {
                client()
            }
        }
    }
    
    private func client() {
        //        let board = Board()
        //        var iterator = board.list.makeIterator()
        //
        //        while iterator.next() == nil {
        //            let _ = iterator.next()
        //        }
        
        let board = Board()
        board.list.append(Post(title: "test1"))
        board.list.append(Post(title: "test2"))
        board.list.append(Post(title: "test3"))
        
        let itorator = BoardIterator(posts: board.list.makeIterator())
        while let value = itorator.next() {
            print("value: \(value)")
        }
        
        // 실제 사용 예시
        let song1 = Song(title: "Shape of You", artist: "Ed Sheeran")
        let song2 = Song(title: "Blinding Lights", artist: "The Weeknd")
        let song3 = Song(title: "Levitating", artist: "Dua Lipa")
        
        let playlist = Playlist()
        playlist.addSong(song1)
        playlist.addSong(song2)
        playlist.addSong(song3)
        
        let iterator = playlist.makeIterator()
        
        print("음악 재생 시작:")
        while iterator.hasNext {
            if let song = iterator.next() {
                print("Now playing: \(song.title) by \(song.artist)")
            }
        }
    }
}

class Board {
    var list = [Post]()
}

struct Post {
    let title: String
}

class BoardIterator: IteratorProtocol {
    
    typealias Element = Post
    
    private var posts: IndexingIterator<[Post]>
    
    init(posts: IndexingIterator<[Post]>) {
        self.posts = posts
    }
    
    func next() -> Post? {
        return posts.next()
    }
}

// 노래(Song) 클래스 정의
struct Song {
    let title: String
    let artist: String
}

// 노래 이터레이터 프로토콜 정의
protocol SongIterator {
    func next() -> Song?
    var hasNext: Bool { get }
}

// 재생 목록(Playlist) 클래스
class Playlist {
    private var songs: [Song] = []
    
    func addSong(_ song: Song) {
        songs.append(song)
    }
    
    func makeIterator() -> SongIterator {
        return PlaylistIterator(songs)
    }
}

// 재생 목록 이터레이터 구현
class PlaylistIterator: SongIterator {
    private var current = 0
    private let songs: [Song]
    
    init(_ songs: [Song]) {
        self.songs = songs
    }
    
    var hasNext: Bool {
        return current < songs.count
    }
    
    func next() -> Song? {
        guard hasNext else { return nil }
        let song = songs[current]
        current += 1
        return song
    }
}

class RandomPlaylistIterator: SongIterator {
    private var songs: [Song]
    
    init(_ songs: [Song]) {
        self.songs = songs.shuffled()  // 랜덤으로 셔플
    }
    
    private var current = 0
    
    var hasNext: Bool {
        return current < songs.count
    }
    
    func next() -> Song? {
        guard hasNext else { return nil }
        let song = songs[current]
        current += 1
        return song
    }
}
