//
//  예제_문서생성기.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/03/18.
//

import Foundation

// 템플릿 콜백 -> 위임을 사용한 예제
protocol DocumentGenerator {
    func generateHeader()
    func generateContent()
    func generateFooter()
    func saveDocument()
    
    // 템플릿 메소드
    func generateDocument()
}

extension DocumentGenerator {
    func generateDocument() {
        generateHeader()
        generateContent()
        generateFooter()
        saveDocument()
    }
}

class PDFDocumentGenerator: DocumentGenerator {
    func generateHeader() {
        // PDF 형식의 헤더 생성 로직
    }
    
    func generateContent() {
        // PDF 형식의 내용 생성 로직
    }
    
    func generateFooter() {
        // PDF 형식의 푸터 생성 로직
    }
    
    func saveDocument() {
        // PDF 형식으로 문서 저장 로직
    }
}

class HTMLDocumentGenerator: DocumentGenerator {
    func generateHeader() {
        // HTML 형식의 헤더 생성 로직
    }
    
    func generateContent() {
        // HTML 형식의 내용 생성 로직
    }
    
    func generateFooter() {
        // HTML 형식의 푸터 생성 로직
    }
    
    func saveDocument() {
        // HTML 형식으로 문서 저장 로직
    }
}
