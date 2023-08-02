//
//  DailyScrum.swift
//  TutorialAdvanced
//
//  Created by Ham Seonwoo on 2023/08/01.
//

import Foundation

// 구조체에 title: String, attendees: [String], lengthInMinutes: Int, theme: Theme 들어갈것

struct DailyScrum: Identifiable {
    var id : UUID
    var title: String
    var attendees: [Attendee]
    var lengthInMinutes: Int
    // 수정할때 시간 표시를 위해 만든 변수 -> 이거 슬라이더랑 연결되는 변수
    var lengthInMinutesAsDouble: Double {
        // 값을 읽는다고 생각
        get {
            Double(lengthInMinutes)
        }
        // 이건 슬라이더를 통해 값이 변동된다면 그 lenghInMinutes 값을 Integer로 변경하여 다시 lengthInMinutes에 할당
        // set은 값을 넣어주는 것
        set {
            lengthInMinutes = Int(newValue)
        }
    }
    var theme: Theme
    var history: [History] = []
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        
        
//        self.attendees = attendees.map({ name in
//            Attendee(name: name)
//        })
        self.attendees = attendees.map { Attendee(name: $0) }
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
    
}


extension DailyScrum {
    
    struct Attendee: Identifiable{
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    
    static var emptyScrum: DailyScrum {
        DailyScrum(title: "", attendees: [], lengthInMinutes: 5, theme: .sky)
    }
    
}


// 왜 확장해서 사용해..?
// 음... . .. .. 활용성에 대한 부분이라고 생각하면 되나.. 그냥 활용성이라고 생각하자 !
//
extension DailyScrum {
    static let sampleData: [DailyScrum] =
    [
        DailyScrum(title: "Design",
                   attendees: ["Cathy", "Daisy", "Simon", "Jonathan"],
                   lengthInMinutes: 10,
                   theme: .yellow),
        DailyScrum(title: "App Dev",
                   attendees: ["Katie", "Gray", "Euna", "Luis", "Darla"],
                   lengthInMinutes: 5,
                   theme: .orange),
        DailyScrum(title: "Web Dev",
                   attendees: ["Chella", "Chris", "Christina", "Eden", "Karla", "Lindsey", "Aga", "Chad", "Jenn", "Sarah"],
                   lengthInMinutes: 5,
                   theme: .poppy)
    ]
}
