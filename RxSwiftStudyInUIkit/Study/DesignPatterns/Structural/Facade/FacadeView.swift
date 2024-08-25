//
//  FacadeViewController.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/02/11.
//

import SwiftUI

struct FacadeView: View {
    
    private let textViewContent: String = """
        [ 퍼사드 패턴 ]
        건물의 외관, 입구쪽을 바라본 전경
        건물 안에 뭐가 있는지는 알 수 없음
        유연한 개발을 위해 약결합 시스템(Loosely Coupled System) 에 대해 생각해보아야 함
        
        클라이언트가 사용해야 하는 복잡한 서브 시스템 의존성을 간단한 인터페이스로 추상화 할 수 있다.
        복잡한 기능은 퍼사드 뒤로 숨김
        
        [장점]
        서브 시스템에 대한 의존성을 한 곳으로 모을 수 있다.
        
        [단점]
        퍼사드 클래스가 서브 시스템에 대한 모든 의존성을 가지게 된다.
        코드가 읽기 편해지면 리팩토링을 했다라고 생각한다(by 백기선)
        내부구조를 디테일하게 알지 않아도됨
        
        [사용예시]
        1. 이미지 다운로드
        UIImageView에 이미지를 적용하는 기능을 만들때
        downloadImage(url...) 함수를 만든다고 생각해보자
        
        우리는 downloadImage 함수를 갖는 퍼사드 클래스를 만들고,
        ImageDownloader를 주입해주고 사용할 수 있을것이다.
        # https://refactoring.guru/ko/design-patterns/facade/swift/example#example-1
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
                """)
            }
            .background(Color(UIColor.systemBackground).edgesIgnoringSafeArea(.all))
            .onAppear {
                // email을 보내는 기능을 여러곳에서 쓴다고 했을때 유용하게 쓸 수 있다.
                // 각각 interface를 두고 개발하면 다른 Sender들을 적용시킬 수 있음
                EmailSender(emailSetngs: EmailSettings(host: "127.0.0.1"))
                    .sendEmail(
                        emailMessage: EmailMessage(
                            title: "이메일 제목",
                            text: "email contents",
                            to: "jhon",
                            from: "sujin"
                        )
                    )
                
                // 이미지 다운로더 예시
                let imageUrl = URL(string: "https://example.com/image.png")!
                let imageDownloader = ImageDownloaderFacade()

                imageDownloader.downloadImage(from: imageUrl, saveAs: "downloaded_image.png") { success in
                    if success {
                        print("Image downloaded and saved successfully!")
                    } else {
                        print("Failed to download and save image.")
                    }
                }
            }
        }
    }
    
    private func client() {
        // email을 보내는 기능을 여러곳에서 쓴다고 했을때 유용하게 쓸 수 있다.
        // 각각 interface를 두고 개발하면 다른 Sender들을 적용시킬 수 있음
        EmailSender(emailSetngs: EmailSettings(host: "127.0.0.1"))
            .sendEmail(
                emailMessage: EmailMessage(
                    title: "이메일 제목",
                    text: "email contents",
                    to: "jhon",
                    from: "sujin"
                )
            )
        
        let imageUrl = URL(string: "https://example.com/image.png")!
        let imageDownloader = ImageDownloaderFacade()

        imageDownloader.downloadImage(from: imageUrl, saveAs: "downloaded_image.png") { success in
            if success {
                print("Image downloaded and saved successfully!")
            } else {
                print("Failed to download and save image.")
            }
        }
    }
}

class EmailSender {
    
    let emailSetngs: EmailSettings
    
    init(emailSetngs: EmailSettings) {
        self.emailSetngs = emailSetngs
    }
    
    func sendEmail(emailMessage: EmailMessage) {
        print("send email use this settings - host: \(emailSetngs.host)")
        print("send email - from: \(emailMessage.from) title: \(emailMessage.title)")
    }
}

class EmailSettings {
    var host: String
    
    init(host: String) {
        self.host = host
    }
}

class EmailMessage {
    let title: String
    let text: String
    let to: String
    let from: String
    
    init(title: String, text: String, to: String, from: String) {
        self.title = title
        self.text = text
        self.to = to
        self.from = from
    }
}

import Foundation

class NetworkService {
    func downloadImage(from url: URL, completion: @escaping (Data?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Failed to download image:", error ?? "")
                completion(nil)
                return
            }
            completion(data)
        }
        task.resume()
    }
}

class ImageProcessingService {
    func processImageData(_ data: Data) -> Data? {
        // 필요한 이미지 처리 로직 추가 가능
        // 예를 들어 이미지 포맷 변환, 크기 조절 등이 포함될 수 있음
        return data
    }
}

class FileService {
    func saveImage(data: Data, to fileName: String) -> Bool {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            try data.write(to: fileURL)
            return true
        } catch {
            print("Failed to save image:", error)
            return false
        }
    }

    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

class ImageDownloaderFacade {
    private let networkService = NetworkService()
    private let imageProcessingService = ImageProcessingService()
    private let fileService = FileService()

    func downloadImage(from url: URL, saveAs fileName: String, completion: @escaping (Bool) -> Void) {
        networkService.downloadImage(from: url) { [weak self] data in
            guard let self = self, let data = data else {
                completion(false)
                return
            }
            
            if let processedData = self.imageProcessingService.processImageData(data) {
                let success = self.fileService.saveImage(data: processedData, to: fileName)
                completion(success)
            } else {
                completion(false)
            }
        }
    }
}
