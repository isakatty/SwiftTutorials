//
//  History.swift
//  TutorialAdvanced
//
//  Created by Ham Seonwoo on 2023/08/02.
//

import Foundation

// 언제 누가 참석했는지 알려주는 데이터 바구니

struct History: Identifiable {
    
    let id: UUID
    let date: Date
    var attendees: [DailyScrum.Attendee]
    
    init(id: UUID = UUID(), date: Date = Date(), attendees: [DailyScrum.Attendee]) {
        self.id = id
        self.date = date
        self.attendees = attendees
    }
}
