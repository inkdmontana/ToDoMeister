import SwiftUI

struct TaskDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var task: Task
    @State private var showingEditTaskView = false

    var body: some View {
        NavigationView {
            Form {
                Text(task.title)
                    .font(.headline)
                Text(task.description)
                    .font(.subheadline)
                Text("Due Date: \(task.dueDate, formatter: dateFormatter)")
                Text("Priority: \(task.priority)")
                Toggle("Complete", isOn: $task.isComplete)
                Button("Edit Task") {
                    showingEditTaskView.toggle()
                }
                .sheet(isPresented: $showingEditTaskView) {
                    EditTaskView(task: $task, onDelete: {})
                }
            }
            .navigationTitle("Task Details")
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}

struct TaskDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDetailsView(task: .constant(Task(title: "Sample Task", description: "Sample Description", dueDate: Date(), priority: "Medium", isComplete: false)))
    }
}
