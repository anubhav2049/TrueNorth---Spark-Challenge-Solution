import SwiftUI

struct HistoryCalendarView: View {
    @Binding var path: NavigationPath
    @EnvironmentObject var dailyLogManager: DailyLogManager
    @State private var selectedDate: Date? = nil

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color(hex: "#fdfbfb"), Color(hex: "#ebedee")],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            ScrollView{
                VStack {
                    Text("Reflection History")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top)
                    
                    DatePicker("Select a Day", selection: Binding(
                        get: { selectedDate ?? Date() },
                        set: { selectedDate = $0 }
                    ), displayedComponents: [.date])
                    .datePickerStyle(.graphical)
                    .padding()
                    
                    if let date = selectedDate,
                       let entry = dailyLogManager.entries[Calendar.current.startOfDay(for: date)] {
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text("🧠 Mood Rating:")
                                .font(.headline)
                            Text("\(entry.moodRating)/10")
                                .font(.title3)
                                .foregroundColor(.purple)
                            
                            Text("📝 Journal Entry:")
                                .font(.headline)
                            Text(entry.journal)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text("💬 How You Felt:")
                                .font(.headline)
                            Text(entry.feeling)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            if !entry.goals.isEmpty {
                                Text("✅ Completed Goals:")
                                    .font(.headline)
                                ForEach(entry.goals.filter { $0.isCompleted }) { goal in
                                    Text("- \(goal.title)")
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                        .padding(.top)
                    } else {
                        Text("No entries for this day.")
                            .foregroundColor(.gray)
                            .padding(.top)
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
}

