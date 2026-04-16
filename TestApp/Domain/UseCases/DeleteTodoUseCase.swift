import Foundation

struct DeleteTodoUseCase {
    let repository: TodoRepository

    func execute(id: UUID) async throws {
        try await repository.delete(id: id)
    }
}
