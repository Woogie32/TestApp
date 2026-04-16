import Testing
import Foundation
@testable import ToDoList

struct AddTodoUseCaseTests {

    @Test
    func 빈_제목은_추가되지_않는다() async throws {
        let repository = MockTodoRepository()
        let useCase = AddTodoUseCase(repository: repository)

        try await useCase.execute(title: "")
        try await useCase.execute(title: "   ")
        try await useCase.execute(title: "\n\t")

        let stored = await repository.storage
        #expect(stored.isEmpty)
    }

    @Test
    func 유효한_제목은_추가된다() async throws {
        let repository = MockTodoRepository()
        let useCase = AddTodoUseCase(repository: repository)

        try await useCase.execute(title: "SwiftUI 공부")

        let stored = await repository.storage
        #expect(stored.count == 1)
        #expect(stored.first?.title == "SwiftUI 공부")
        #expect(stored.first?.isCompleted == false)
    }

    @Test
    func 앞뒤_공백은_제거된다() async throws {
        let repository = MockTodoRepository()
        let useCase = AddTodoUseCase(repository: repository)

        try await useCase.execute(title: "  Todo 앱 만들기  ")

        let stored = await repository.storage
        #expect(stored.first?.title == "Todo 앱 만들기")
    }
}
