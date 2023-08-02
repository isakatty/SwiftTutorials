//
//  ContentView.swift
//  TutorialAdvanced
//
//  Created by Ham Seonwoo on 2023/08/01.
//

import SwiftUI
// 소리 날 수 있게~
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    //@StateObject는 view가 그 객체를 소유해
    @StateObject var scrumTimer = ScrumTimer()
    
    private var player: AVPlayer{ AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16.0)
                            .fill(scrum.theme.mainColor)
            
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                
                Circle()
                    .strokeBorder(lineWidth: 24)
                
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        // 뷰가 나타난 후 애니메이션을 시작
        .onAppear {
            startScrum()
        }
        // 뷰가 사라질 때 불필요한 리소스를 해제
        // 사용자와의 상호작용 없이 update할때 사용해서 뷰 업데이트
        .onDisappear {
            endScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func startScrum(){
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
        }
        scrumTimer.startScrum()
    }
    
    private func endScrum() {
        scrumTimer.stopScrum()
        let newHistory = History(attendees: scrum.attendees)
        scrum.history.insert(newHistory, at: 0)
    }
    
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
