import SwiftUI

struct ContentView: View {
    @State private var viewModel: TodoListViewModel
    @State private var isAddPresented: Bool = false

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
            .overlay(alignment: .bottomTrailing) {
                addButton
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
            }
            .task { await viewModel.load() }
            .sheet(isPresented: $isAddPresented) {
                AddTodoView(viewModel: viewModel)
            }
            .alert(
                "오류",
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil },
                    set: { if !$0 { viewModel.errorMessage = nil } }
                )
            ) {
                Button("확인", role: .cancel) { viewModel.errorMessage = nil }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }

    private var addButton: some View {
        Button {
            isAddPresented = true
        } label: {
            Image(systemName: "plus")
                .font(.title2.weight(.semibold))
                .foregroundStyle(.white)
                .frame(width: 56, height: 56)
                .background(Color.accentColor, in: Circle())
                .shadow(color: Color.accentColor.opacity(0.3), radius: 12, x: 0, y: 4)
        }
        .accessibilityLabel("할 일 추가")
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
