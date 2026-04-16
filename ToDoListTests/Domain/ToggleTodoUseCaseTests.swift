import Testing
import Foundation
@testable import ToDoList

struct ToggleTodoUseCaseTests {

    @Test
    func 완료되지_않은_Todo를_토글하면_완료된다() async throws {
        let todo = Todo(title: "테스트")
        let repository = MockTodoRepository()
        await repository.seed([todo])
        let useCase = ToggleTodoUseCase(repository: repository)

        try await useCase.execute(todo)

        let stored = await repository.storage
        #expect(stored.first?.isCompleted == true)
    }

    @Test
    func 완료된_Todo를_토글하면_미완료로_돌아간다() async throws {
        let todo = Todo(title: "테스트", isCompleted: true)
        let repository = MockTodoRepository()
        await repository.seed([todo])
        let useCase = ToggleTodoUseCase(repository: repository)

        try await useCase.execute(todo)

        let stored = await repository.storage
        #expect(stored.first?.isCompleted == false)
    }
}
