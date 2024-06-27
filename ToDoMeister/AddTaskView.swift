import SwiftUI

struct AddTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var tasks: [Task]
    @State private var title = ""
    @State private var description = ""
    @State private var dueDate = Date()
    @State private var priority = "Low"
    let priorities = ["Low", "Medium", "High"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $title)
                DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                TextField("Description", text: $description)
                Picker("Priority", selection: $priority) {
                    ForEach(priorities, id: \.self) {
                        Text($0)
                    }
                }
                Button("Save Task") {
                    let newTask = Task(title: title, description: description, dueDate: dueDate, priority: priority, isComplete: false)
                    tasks.append(newTask)
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Add New Task")
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(tasks: .constant([Task(title: "Sample Task", description: "Sample Description", dueDate: Date(), priority: "Medium", isComplete: false)]))
    }
}
