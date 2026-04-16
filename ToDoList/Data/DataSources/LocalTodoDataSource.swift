import Foundation

protocol TodoDataSource: Sendable {
    func fetchAll() async throws -> [TodoDTO]
    func add(_ dto: TodoDTO) async throws
    func update(_ dto: TodoDTO) async throws
    func delete(id: UUID) async throws
}

actor LocalTodoDataSource: TodoDataSource {
    private var storage: [TodoDTO] = []

    func fetchAll() async throws -> [TodoDTO] {
        storage
    }

    func add(_ dto: TodoDTO) async throws {
        storage.append(dto)
    }

    func update(_ dto: TodoDTO) async throws {
        guard let index = storage.firstIndex(where: { $0.id == dto.id }) else { return }
        storage[index] = dto
    }

    func delete(id: UUID) async throws {
        storage.removeAll { $0.id == id }
    }
}
