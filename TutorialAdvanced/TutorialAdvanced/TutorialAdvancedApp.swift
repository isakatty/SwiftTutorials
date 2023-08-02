//
//  TutorialAdvancedApp.swift
//  TutorialAdvanced
//
//  Created by Ham Seonwoo on 2023/08/01.
//

import SwiftUI

@main
struct TutorialAdvancedApp: App {
    @State private var scrums : [DailyScrum] = DailyScrum.sampleData
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}
