//
//  Text-to-speech-model.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 6/9/22.
//

import Foundation

class TexttoSpeech {
    var orig_text:String
    var sp_lang: String
    
    init(from_text: String, speech_lang: String) {
        orig_text = from_text
        sp_lang = speech_lang
    }
    
    func speech_text() {
        print("run func")
    }
}
