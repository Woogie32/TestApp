import SwiftUI

@main
struct ToDoListApp: App {
    @State private var viewModel = Self.makeViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }

    @MainActor
    private static func makeViewModel() -> TodoListViewModel {
        let dataSource = LocalTodoDataSource()
        let repository = TodoRepositoryImpl(dataSource: dataSource)
        return TodoListViewModel(
            fetchTodos: FetchTodosUseCase(repository: repository),
            addTodo: AddTodoUseCase(repository: repository),
            toggleTodo: ToggleTodoUseCase(repository: repository),
            deleteTodo: DeleteTodoUseCase(repository: repository)
        )
    }
}
