//
//  CodeView.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 7/6/24.
//

import SwiftUI

struct CodeView2: View {
    
    @ObservedObject var config = Config.shared
    let code: String
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(code.split(separator: "\n"), id: \.self) { line in
                highlightedText(for: String(line))
                    .padding(.vertical, 1)
            }
        }
        .padding(.all, 0)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
    func highlightedText(for line: String) -> Text {
        let keywords = ["struct", "var", "let", "func", "if", "else", "for", "while", "return"]
        var highlightedLine = Text("")
        
        if let commentRange = line.range(of: "//") {
            let codePart = line[..<commentRange.lowerBound]
            let commentPart = line[commentRange.lowerBound...]
            
            let codeWords = codePart.split(separator: " ")
            for word in codeWords {
                let word = String(word)
                if keywords.contains(String(word)) {
                    highlightedLine = highlightedLine + Text(" \(word)").foregroundColor(.blue).bold()
                } else if word.hasPrefix("\"") && word.hasSuffix("\"") {
                    highlightedLine = highlightedLine + Text(" \(word)").foregroundColor(.purple)
                } else {
                    highlightedLine = highlightedLine + Text(" \(word)").foregroundColor(.primary)
                }
            }
            highlightedLine = highlightedLine + Text(" \(String(commentPart))").foregroundColor(.gray)
        } else {
            let words = line.split(separator: " ")
            for word in words {
                let word = String(word)
                if keywords.contains(String(word)) {
                    highlightedLine = highlightedLine + Text(" \(word)").foregroundColor(.blue).bold()
                } else if word.hasPrefix("\"") && word.hasSuffix("\"") {
                    highlightedLine = highlightedLine + Text(" \(word)").foregroundColor(.purple)
                } else {
                    highlightedLine = highlightedLine + Text(" \(word)").foregroundColor(.primary)
                }
            }
        }
        
        return highlightedLine.font(.system(size: config.codeViewFontSize))
    }
}
struct CodeView: View {
    
    @ObservedObject var config = Config.shared
    let code: String
    
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            VStack(alignment: .leading) {
                ForEach(code.split(separator: "\n"), id: \.self) { line in
                    highlightedText(for: String(line))
                        .padding(.vertical, 1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding(.all, 0)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(8)
        }
        .padding()
    }
    
    func highlightedText(for line: String) -> Text {
        let keywords = ["struct", "var", "let", "func", "if", "else", "for", "while", "return"]
        var highlightedLine = Text("")

        if let commentRange = line.range(of: "//") {
            let codePart = line[..<commentRange.lowerBound]
            let commentPart = line[commentRange.lowerBound...]
            
            let codeWords = codePart.split(separator: " ", omittingEmptySubsequences: false)
            for word in codeWords {
                let word = String(word)
                if keywords.contains(word) {
                    highlightedLine = highlightedLine + Text(word).foregroundColor(.blue).bold()
                } else if word.hasPrefix("\"") && word.hasSuffix("\"") {
                    highlightedLine = highlightedLine + Text(word).foregroundColor(.purple)
                } else {
                    highlightedLine = highlightedLine + Text(word).foregroundColor(.primary)
                }
                highlightedLine = highlightedLine + Text(" ")
            }
            highlightedLine = highlightedLine + Text(commentPart).foregroundColor(.gray)
        } else {
            let words = line.split(separator: " ", omittingEmptySubsequences: false)
            for word in words {
                let word = String(word)
                if keywords.contains(word) {
                    highlightedLine = highlightedLine + Text(word).foregroundColor(.blue).bold()
                } else if word.hasPrefix("\"") && word.hasSuffix("\"") {
                    highlightedLine = highlightedLine + Text(word).foregroundColor(.purple)
                } else {
                    highlightedLine = highlightedLine + Text(word).foregroundColor(.primary)
                }
                highlightedLine = highlightedLine + Text(" ")
            }
        }
        
        return highlightedLine.font(.system(size: config.codeViewFontSize))
    }
}
