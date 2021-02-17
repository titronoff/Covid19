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
}
