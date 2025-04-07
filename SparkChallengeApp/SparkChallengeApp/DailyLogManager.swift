import Foundation

class DailyLogManager: ObservableObject {
    @Published var entries: [Date: DailyEntry] = [:]

    func saveEntry(date: Date, journal: String, feeling: String, moodRating: Int, goals: [Goal] = []) {
        let entry = DailyEntry(date: date, journal: journal, feeling: feeling, goals: goals, moodRating: moodRating)
        entries[Calendar.current.startOfDay(for: date)] = entry
    }
}

