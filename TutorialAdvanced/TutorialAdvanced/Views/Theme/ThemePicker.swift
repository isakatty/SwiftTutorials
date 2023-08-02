//
//  ThemePicker.swift
//  TutorialAdvanced
//
//  Created by Ham Seonwoo on 2023/08/02.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme
    
    var body: some View {
        Picker("Theme", selection: $selection) {
            // Theme은 열거형. 열거형의 case들을 배열 컬렉션으로 사용할 수 있게 만들어주는 protocol
            //ForEach
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
            
        }
        .pickerStyle(.navigationLink)
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        ThemePicker(selection: .constant(.periwinkle))
    }
}
