//
//  MarkerExample.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/03/18.
//

import Foundation

// element
protocol Marker {
    func draw(on map: Map) // excute
}

class LocalMarker: Marker {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func draw(on map: Map) {
        // 지역마커를 지도에 그리는 코드
        map.draw(marker: self)
    }
}

class ComplexMarker: Marker {
    var id: String
    
    init(id: String) {
        self.id = id
    }
    
    func draw(on map: Map) {
        // 단지마커를 지도에 그리는 코드
        map.draw(marker: self)
    }
}

class VillaMarker: Marker {
    var location: String
    
    init(location: String) {
        self.location = location
    }
    
    func draw(on map: Map) {
        // 빌라마커를 지도에 그리는 코드
        map.draw(marker: self)
    }
}

// Visitor
protocol MapDrawProtocol {
    
    func draw(marker: LocalMarker)
    func draw(marker: ComplexMarker)
    func draw(marker: VillaMarker)
}

final class Map: MapDrawProtocol {
    
    func draw(marker: LocalMarker) {
        print("Draw LocalMarker \(marker) on the map")
    }
    
    func draw(marker: ComplexMarker) {
        print("Draw ComplexMarker \(marker) on the map")
    }
    
    func draw(marker: VillaMarker) {
        print("Draw VillaMarker \(marker) on the map")
    }
}

class MapDrawer {
    func drawMarkers(on map: Map, markers: [Marker]) {
        for marker in markers {
            marker.draw(on: map)
        }
    }
}
