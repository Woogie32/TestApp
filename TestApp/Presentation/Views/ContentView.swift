import SwiftUI

struct ContentView: View {
    @State private var viewModel: TodoListViewModel
    @State private var newTodoTitle: String = ""

    init(viewModel: TodoListViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.todos) { todo in
                    TodoRowView(todo: todo) {
                        Task { await viewModel.toggle(todo) }
                    }
                }
                .onDelete { indexSet in
                    let idsToDelete = indexSet.map { viewModel.todos[$0].id }
                    Task {
                        for id in idsToDelete {
                            await viewModel.delete(id: id)
                        }
                    }
                }
            }
            .navigationTitle("Todo")
            .safeAreaInset(edge: .bottom) {
                HStack(spacing: 8) {
                    TextField("할 일을 입력하세요", text: $newTodoTitle)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        let title = newTodoTitle
                        newTodoTitle = ""
                        Task { await viewModel.add(title: title) }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .accessibilityLabel("할 일 추가")
                }
                .padding(16)
                .background(Color(.systemBackground))
            }
            .task { await viewModel.load() }
        }
    }
}

@MainActor
private func makePreviewViewModel() -> TodoListViewModel {
    let dataSource = LocalTodoDataSource()
    let repository = TodoRepositoryImpl(dataSource: dataSource)
    return TodoListViewModel(
        fetchTodos: FetchTodosUseCase(repository: repository),
        addTodo: AddTodoUseCase(repository: repository),
        toggleTodo: ToggleTodoUseCase(repository: repository),
        deleteTodo: DeleteTodoUseCase(repository: repository)
    )
}

#Preview("Light") {
    ContentView(viewModel: makePreviewViewModel())
}

#Preview("Dark") {
    ContentView(viewModel: makePreviewViewModel())
        .preferredColorScheme(.dark)
}
