import SwiftUI

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var task: Task
    var onDelete: () -> Void

    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $task.title)
                DatePicker("Due Date", selection: $task.dueDate, displayedComponents: .date)
                TextField("Description", text: $task.description)
                Picker("Priority", selection: $task.priority) {
                    ForEach(["Low", "Medium", "High"], id: \.self) {
                        Text($0)
                    }
                }
                Button("Save Changes") {
                    presentationMode.wrappedValue.dismiss()
                }
                Button("Delete Task") {
                    onDelete()
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.red)
            }
            .navigationTitle("Edit Task")
        }
    }
}

struct EditTaskView_Previews: PreviewProvider {
    static var previews: some View {
        EditTaskView(task: .constant(Task(title: "Sample Task", description: "Sample Description", dueDate: Date(), priority: "Medium", isComplete: false)), onDelete: {})
    }
}
