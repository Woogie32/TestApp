import Foundation

struct ToggleTodoUseCase {
    let repository: TodoRepository

    func execute(_ todo: Todo) async throws {
        var updated = todo
        updated.isCompleted.toggle()
        try await repository.update(updated)
    }
}
