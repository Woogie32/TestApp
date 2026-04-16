import Foundation
import Observation

@MainActor
@Observable
final class TodoListViewModel {
    private(set) var todos: [Todo] = []
    var errorMessage: String?

    private let fetchTodos: FetchTodosUseCase
    private let addTodo: AddTodoUseCase
    private let toggleTodo: ToggleTodoUseCase
    private let deleteTodo: DeleteTodoUseCase

    init(
        fetchTodos: FetchTodosUseCase,
        addTodo: AddTodoUseCase,
        toggleTodo: ToggleTodoUseCase,
        deleteTodo: DeleteTodoUseCase
    ) {
        self.fetchTodos = fetchTodos
        self.addTodo = addTodo
        self.toggleTodo = toggleTodo
        self.deleteTodo = deleteTodo
    }

    func load() async {
        do {
            todos = try await fetchTodos.execute()
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func add(title: String) async {
        do {
            try await addTodo.execute(title: title)
            await load()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func toggle(_ todo: Todo) async {
        do {
            try await toggleTodo.execute(todo)
            await load()
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func delete(id: UUID) async {
        do {
            try await deleteTodo.execute(id: id)
            await load()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
