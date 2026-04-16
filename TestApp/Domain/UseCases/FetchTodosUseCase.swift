import Foundation

struct FetchTodosUseCase {
    let repository: TodoRepository

    func execute() async throws -> [Todo] {
        try await repository.fetchAll()
    }
}
