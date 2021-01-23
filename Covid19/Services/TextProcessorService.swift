//
//  Editor.swift
//  Covid19
//
//  Created by Pavel Ivanovski on 25.11.20.
//

import Foundation

protocol TextProcessor {
    func zeroChanger (_ input: Int) -> String
}

class TextProcessorService: TextProcessor {
    func zeroChanger (_ input: Int) -> String {
        if input == 0 {
            return "N/A"
        } else {
            return String(input)
        }
    }
//    class  func htmlCleaner(_ input: String) -> String {
//        guard let inocodeInput = input.data(using: .unicode) else { return ""}
//        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
//                        .documentType: NSAttributedString.DocumentType.html
//                     ]
//        let attributedHTMLString = try! NSAttributedString(data: inocodeInput, options: options, documentAttributes: nil)
//        return String(attributedHTMLString)
//    }
}
