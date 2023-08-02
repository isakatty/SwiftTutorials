//
//  TrailingIconLabelStyle.swift
//  TutorialAdvanced
//
//  Created by Ham Seonwoo on 2023/08/01.
//

import Foundation
import SwiftUI

// LabelStyle protocol을 따르는 TrailingIconLabelStyle 구조체 만듦.
struct TrailingIconLabelStyle: LabelStyle {
    // View에서 바디를 이용하여 뷰를 구성하듯이 여기서는 View의 역할을 할 수 있는 함수를 생성
    func makeBody(configuration: Configuration) -> some View {
        //configuration 매개변수는 icon 및 title view가 포함된 LabelStyleConfiguration. 이러한 보기는 레이블의 이미지와 레이블 텍스트를 나타냅니다.
        HStack{
            configuration.title
            configuration.icon
        }
    }

}

extension LabelStyle where Self == TrailingIconLabelStyle {
    static var trailingIcon: Self { Self() }
}

// 이걸 사용해주면 만들어놨던 형태에서 다 오른쪽 정렬을 넣어주는것
