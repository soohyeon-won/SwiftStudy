//
//  FileProcessor.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2023/03/18.
//

import Foundation
class FileProcessor {
    // The template method defines the algorithm for processing a file
    func processFile(at path: String) {
        let contents = readContents(at: path)
        let processedContents = processContents(contents)
        writeContents(processedContents, at: path)
    }
    
    // These methods are the "callback" methods that are implemented by subclasses
    func processContents(_ contents: String) -> String {
        return contents // Default implementation just returns the original contents
    }
    
    func readContents(at path: String) -> String {
        fatalError("Must be implemented by subclass") // Abstract method
    }
    
    func writeContents(_ contents: String, at path: String) {
        fatalError("Must be implemented by subclass") // Abstract method
    }
}

class TextFileProcessor: FileProcessor {
    override func processContents(_ contents: String) -> String {
        print("TextFileProcessor contents: \(contents)")
        return contents.uppercased() // Custom implementation for processing text files
    }
    
    override func readContents(at path: String) -> String {
        // Custom implementation for reading text files
        // ...
        print("TextFileProcessor path: \(path)")
        return "\(path)"
    }
    
    override func writeContents(_ contents: String, at path: String) {
        // Custom implementation for writing text files
        // ...
        print("TextFileProcessor contents: \(contents), path: \(path)")
    }
}

class ImageFileProcessor: FileProcessor {
    override func processContents(_ contents: String) -> String {
        print("ImageFileProcessor contents: \(contents)")
        return "This file cannot be processed as it is an image." // Custom behavior for processing image files
    }
    
    override func readContents(at path: String) -> String {
        print("ImageFileProcessor path: \(path)")
        return path
//        fatalError("Image files cannot be read as text.") // Custom behavior for reading image files
    }
    
    override func writeContents(_ contents: String, at path: String) {
        print("ImageFileProcessor contents: \(contents), path: \(path)")
//        fatalError("Image files cannot be written as text.") // Custom behavior for writing image files
    }
}
