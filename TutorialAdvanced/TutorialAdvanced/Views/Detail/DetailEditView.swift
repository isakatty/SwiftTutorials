//
//  DetailEditView.swift
//  TutorialAdvanced
//
//  Created by Ham Seonwoo on 2023/08/01.
//

import SwiftUI

// Edit View이기 때문에 이 창이 열렸을때 수정할 수 있어야함
// 수정 요소 : title, 시간, 참여자

// 여기서 수정된 값을 가지고 DetailView에 값이 변동되어야함.
// 그럼 데이터 연동될 것은 여러 뷰에서 참조되어야하니까 @State가 아닌 @Binding


struct DetailEditView: View {
    // @State : property wrapper로, 값의 변경을 인지하여 View를 다시 그려줌
    // 뷰 간 데이터 흐름 관리에서 @State 속성 래퍼가 "값 유형의 데이터 원본을 정의"한다는 점을 기억하세요.
    //
    @Binding var scrum : DailyScrum
    @State private var newAttendeeName = ""
    
    var body: some View {
        Form{
            Section(header: Text("Meetin Info")){
                TextField("Title", text: $scrum.title)
                HStack {
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30, step: 1) {
                        Text("Length")
                    }
                    // 시각 장애를 가지고 있는 사람이 있다면, 이게 어떤 기능을하는 무엇인지 알 수 없기 때문에 voiceOver로 읽어주기 위해 추가 해주는 것.
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                    // 위에서 슬라이더와 동시에 뭔지 읽어주고 있으니까 label을 읽어줄 필요 없음.
                        .accessibilityHidden(true)
                }
                ThemePicker(selection: $scrum.theme)
            }
            Section {
                // 현재 참석자가 없으니까 Text가 보이지 않고 TextField만 보임.
                // 참석자를 추가해주면 반복문에 의해 Text를 보여주는 것!!
                
                ForEach(scrum.attendees) { attendee in
                    Text(attendee.name)
                }
                // onDelete는 forEach에만 적용될걸..?
                // swiping하여 삭제하게 만들어줘
                .onDelete { indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                
                HStack {
                    TextField("New Attendee", text: $newAttendeeName)
                    // 버튼을 누르면 애니메이션 효과와 동시에 Attendee에 추가해주는 것.
                    Button(action: {
                        withAnimation {
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendee)
                            // 버튼이 눌려서 참석자에 newAttendeeName이 추가되고 나면 TextField에 넣은 값이 초기화 되어야 사용하기 편하겠지요 ?
                            newAttendeeName = ""
                        }
                        
                    }) {
                        Image(systemName: "plus.circle.fill")
                        // 추가적인 기능이 없는 것이라면 Label인가봄
                            .accessibilityLabel("Add attendee")
                    }
                    // TextField에 값이 들어오지 않으면 버튼 비활성화
                    .disabled(newAttendeeName.isEmpty)
                }

            } header: {
                Text("Attendees")
            }

        }
    }
}

struct DetailEditView_Previews: PreviewProvider {
    static var previews: some View {
        DetailEditView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
