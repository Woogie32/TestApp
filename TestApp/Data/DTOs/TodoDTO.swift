import Foundation

struct TodoDTO: Codable, Sendable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    let createdAt: Date
}

extension TodoDTO {
    init(from entity: Todo) {
        self.id = entity.id
        self.title = entity.title
        self.isCompleted = entity.isCompleted
        self.createdAt = entity.createdAt
    }

    func toEntity() -> Todo {
        Todo(
            id: id,
            title: title,
            isCompleted: isCompleted,
            createdAt: createdAt
        )
    }
}
