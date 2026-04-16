import Foundation

protocol TodoRepository: Sendable {
    func fetchAll() async throws -> [Todo]
    func add(_ todo: Todo) async throws
    func update(_ todo: Todo) async throws
    func delete(id: UUID) async throws
}
