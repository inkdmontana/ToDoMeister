import SwiftUI

struct TaskListView: View {
    @State private var tasks: [Task] = []
    @State private var showingAddTaskView = false
    @State private var selectedTask: Task?
    @State private var showingTaskDetailsView = false

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
                TaskDetailsView(task: binding(for: task))
            }
        }
    }

    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
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
