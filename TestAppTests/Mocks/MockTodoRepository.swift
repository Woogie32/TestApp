import Foundation
@testable import TestApp

actor MockTodoRepository: TodoRepository {
    private(set) var storage: [Todo] = []
    private let shouldThrow: Error?

    init(shouldThrow: Error? = nil) {
        self.shouldThrow = shouldThrow
    }

    func seed(_ todos: [Todo]) {
        storage = todos
    }

    func fetchAll() async throws -> [Todo] {
        if let shouldThrow { throw shouldThrow }
        return storage
    }

    func add(_ todo: Todo) async throws {
        if let shouldThrow { throw shouldThrow }
        storage.append(todo)
    }

    func update(_ todo: Todo) async throws {
        if let shouldThrow { throw shouldThrow }
        guard let index = storage.firstIndex(where: { $0.id == todo.id }) else { return }
        storage[index] = todo
    }

    func delete(id: UUID) async throws {
        if let shouldThrow { throw shouldThrow }
        storage.removeAll { $0.id == id }
    }
}
