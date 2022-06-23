//
//  Text-to-Speech.swift
//  PAPAY-Swift
//
//  Created by Oskar Wong on 6/9/22.
//

import Foundation
import AVFoundation

class texttospeech{
    var orig_text:String
    var sp_lang:String
    
    init(read_text:String, speech_lang:String){
        orig_text   =   read_text
        sp_lang     =   speech_lang
    }
    
    public func speakthetext() {
        let utterance = AVSpeechUtterance(string: orig_text)
        utterance.voice = AVSpeechSynthesisVoice(language: sp_lang)
        let synthesizer =   AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
}
