import Foundation

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var dueDate: Date
    var priority: String
    var isComplete: Bool
}
