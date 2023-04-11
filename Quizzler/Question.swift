//
//  Question.swift
//  Quizzler
//
//  Created by Andrey on 11.04.2023.
//

import Foundation

struct Question {
    let text: String
    let answer: String
    
    init(q: String, a: String) {
        text = q
        answer = a
    }
}
