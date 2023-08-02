//
//  ScrumsView.swift
//  TutorialAdvanced
//
//  Created by Ham Seonwoo on 2023/08/01.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView = false
    
    var body: some View {
        // struct에 identifiable 프로토콜을 채택했기 때문에 sampleData의 각 요소에 Id값이 설정되기 때문에 리스트로 표현해줄때 id값을 임의로 설정해줄 필요 없음.
        NavigationStack{
            List($scrums){ $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                ToolbarItem {
                    Button {
                        isPresentingNewScrumView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("New Scrum")
                    // plus button에 있어서 voice over 걸어주는것.
                    // 어떤 내용인지 텍스트를 통해서 읽어줌

                }
            }
            .sheet(isPresented: $isPresentingNewScrumView) {
                // is~@#!@를 통해서 modal 창 on/off가 결정되고, 데이터 연동을 위한 @Binding
                NewScrumSheet(isPresentingNewScrumView: $isPresentingNewScrumView, scrums: $scrums)
            }
        }
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        ScrumsView(scrums: .constant(DailyScrum.sampleData))
    }
}
