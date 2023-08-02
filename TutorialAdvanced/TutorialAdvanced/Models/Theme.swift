//
//  Theme.swift
//  TutorialAdvanced
//
//  Created by Ham Seonwoo on 2023/08/01.
//

import SwiftUI
// color을 사용하기 위해 swiftUI framework 추가한 것

enum Theme: String, CaseIterable, Identifiable {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    // foregroundColor를 위해서 ~~ -> 폰트 색깔
    // 밝은 테마 == 어둡게 , 어두운 테마 == 밝게 
    var accentColor: Color {
        switch self { // 여기서 self의 의미: Theme 자체
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }
    
    var mainColor: Color {
        Color(rawValue)
    }
    
    var name: String{
        rawValue.capitalized
    }
    
    var id: String{
        name
    }
}

