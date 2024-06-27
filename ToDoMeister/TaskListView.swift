import SwiftUI

struct TaskListView: View {
    @State private var tasks: [Task] = []
    @State private var showingAddTaskView = false
    @State private var selectedTask: Task?
    @State private var showingTaskDetailsView = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(task.title)
                                .font(.headline)
                            Text(task.description)
                                .font(.subheadline)
                        }
                        Spacer()
                        if task.isComplete {
                            Image(systemName: "checkmark.circle")
                        } else {
                            Image(systemName: "circle")
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedTask = task
                        showingTaskDetailsView.toggle()
                    }
                }
                .onDelete(perform: deleteTask)
            }
            .navigationTitle("ToDo Meister")
            .navigationBarItems(trailing: Button(action: {
                showingAddTaskView.toggle()
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddTaskView) {
                AddTaskView(tasks: $tasks)
            }
            .sheet(item: $selectedTask) { task in
                TaskDetailsView(task: binding(for: task), onDelete: {
                    if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                        deleteTask(at: IndexSet(integer: index))
                    }
                })
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Task Deleted"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    private func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = tasks[index]
            tasks.remove(at: index)
            alertMessage = "The task \"\(task.title)\" has been deleted."
            showAlert = true
        }
    }

    private func binding(for task: Task) -> Binding<Task> {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else {
            fatalError("Task not found")
        }
        return $tasks[index]
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}
