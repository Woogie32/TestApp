import Foundation

final class TodoRepositoryImpl: TodoRepository {
    private let dataSource: TodoDataSource

    init(dataSource: TodoDataSource) {
        self.dataSource = dataSource
    }

    func fetchAll() async throws -> [Todo] {
        let dtos = try await dataSource.fetchAll()
        return dtos.map { $0.toEntity() }
    }

    func add(_ todo: Todo) async throws {
        try await dataSource.add(TodoDTO(from: todo))
    }

    func update(_ todo: Todo) async throws {
        try await dataSource.update(TodoDTO(from: todo))
    }

    func delete(id: UUID) async throws {
        try await dataSource.delete(id: id)
    }
}
