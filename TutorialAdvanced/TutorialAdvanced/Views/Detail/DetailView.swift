//
//  DetailView.swift
//  TutorialAdvanced
//
//  Created by Ham Seonwoo on 2023/08/01.
//

import SwiftUI


// scrum list에서 디테일한 내용에 대해 나열해줄 곳임
struct DetailView: View {
    // editing된 값을 바인딩해서 가져와야 변경된 값을 보여주지 여기에
    @Binding var scrum: DailyScrum
    
    // EditView는 modal창으로 확인할 예정~
    @State private var isPresentingEditView : Bool = false
    // 사용자가 편집 버튼을 탭하면 선택한 스크럼과 일치하도록 이 빈 스크럼을 업데이트합니다.
    // 원래 이거 없을땐 그냥 빈화면이었는데 editingScrum을 해주면서 그 데이터들을 가지고 editing화면이 열려서 수정을 하는 것.
    @State private var editingScrum = DailyScrum.emptyScrum
    
    var body: some View {
        List{
            Section(header: Text("Meeting Info")) {
                NavigationLink {
                    MeetingView(scrum: $scrum)
                } label: {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)

            }
            Section(header: Text("Attendees")){
                // id값이 없어도 돌아가는 이유: DailyScrum extension을 통해서
                // 각 name에 Id 값을 심어줌 ! -> identifiable을 통해서
                ForEach(scrum.attendees){ attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
            Section(header: Text("History")) {
                if scrum.history.isEmpty {
                    Label("No meetings yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(scrum.history) { history in
                    HStack {
                        Image(systemName: "calendar")
                        Text(history.date, style: .date)
                        
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar(content: {
            ToolbarItem {
                Button {
                    isPresentingEditView = true
                    editingScrum = scrum
                } label: {
                    Text("Edit")
                }

            }
        })
        .sheet(isPresented: $isPresentingEditView) {
            // 근데 이걸 굳이 여기서 표현해줘야하나?
            // 뒤에서 바인딩 걸어서 해도 되는거 아냐?
            NavigationStack {
                DetailEditView(scrum: $editingScrum)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        // trailing, leading으로 하지 않아도 되네용
                        //
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel"){
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done"){
                                isPresentingEditView = false
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            DetailView(scrum: .constant(DailyScrum.sampleData[0]))
        }
    }
}
