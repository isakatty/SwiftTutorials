//
//  CardView.swift
//  TutorialAdvanced
//
//  Created by Ham Seonwoo on 2023/08/01.
//

import SwiftUI

//accessibility~~로 하는건 다 접근성 부분에서 추가해주는것.
// 기능은 거의 비슷함 라벨을 텍스트화해서 읽어주는것.

struct CardView: View {
    let scrum: DailyScrum
    
    var body: some View {
        VStack(alignment: .leading){
            Text(scrum.title)
                .font(.headline)
            //스크럼의 제목을 표시하는 텍스트 보기로 이동
                .accessibilityAddTraits(.isHeader)
            Spacer()
            HStack{
                Label("\(scrum.attendees.count)", systemImage: "person.3")
                    .accessibilityLabel("\(scrum.attendees.count) attendees")
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
                    .accessibilityLabel("\(scrum.lengthInMinutes) minute meeting")
                    .labelStyle(.trailingIcon)
            }
            .font(.caption)
        }
        .padding()
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var scrum = DailyScrum.sampleData[0]
    static var previews: some View {
        CardView(scrum: scrum)
            .background(scrum.theme.mainColor)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
