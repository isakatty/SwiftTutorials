//
//  NewScrumSheet.swift
//  TutorialAdvanced
//
//  Created by Ham Seonwoo on 2023/08/02.
//

import SwiftUI

struct NewScrumSheet: View {
    // ScrumsView 뷰에서 이 변수가 true일때 이 뷰가 보여질것이기 때문에 앞에서 값의 변화를 알고 있어야함
    @Binding var isPresentingNewScrumView: Bool
    // 이걸 통해서 scrum을 쓰기 위해 필요한 변수들을 빈 상태로 가져오는 것.
    @State private var newScrum = DailyScrum.emptyScrum
    // Add 버튼 눌렀을때 주입된 내용을 이제 배열에 추가해주는!!
    @Binding var scrums: [DailyScrum]
    
    var body: some View {
        // code 재사용성 미쳣다..
        NavigationStack {
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    // 상단 양측에 버튼을 만들어주고 sheet를 내려주는 코드 주입
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Dismiss") {
                            isPresentingNewScrumView = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Add") {
                            // 여기 내리기 전에 만들어서 넣어주는게 필요하지 않나?
                            // emptyScrum == newScrum이고 빈 scrum에 내용을 채워 넣어준것이 new Scrum. 그걸 배열에 추가해주는 것.
                            scrums.append(newScrum)
                            isPresentingNewScrumView = false
                        }
                    }
                }
        }
    }
}

struct NewScrumSheet_Previews: PreviewProvider {
    static var previews: some View {
        NewScrumSheet(isPresentingNewScrumView: .constant(true), scrums: .constant(DailyScrum.sampleData))
    }
}
