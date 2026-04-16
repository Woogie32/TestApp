import Foundation

struct AddTodoUseCase {
    let repository: TodoRepository

    func execute(title: String) async throws {
        let trimmed = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        let todo = Todo(title: trimmed)
        try await repository.add(todo)
    }
}
