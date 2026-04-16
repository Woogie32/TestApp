import Testing
import Foundation
@testable import ToDoList

@MainActor
struct TodoListViewModelTests {

    private func makeViewModel(repository: MockTodoRepository) -> TodoListViewModel {
        TodoListViewModel(
            fetchTodos: FetchTodosUseCase(repository: repository),
            addTodo: AddTodoUseCase(repository: repository),
            toggleTodo: ToggleTodoUseCase(repository: repository),
            deleteTodo: DeleteTodoUseCase(repository: repository)
        )
    }

    @Test
    func load_호출_시_저장소의_Todo들이_노출된다() async {
        let repository = MockTodoRepository()
        await repository.seed([
            Todo(title: "첫째"),
            Todo(title: "둘째")
        ])
        let viewModel = makeViewModel(repository: repository)

        await viewModel.load()

        #expect(viewModel.todos.count == 2)
        #expect(viewModel.todos.map(\.title) == ["첫째", "둘째"])
        #expect(viewModel.errorMessage == nil)
    }

    @Test
    func add_호출_시_todos에_반영된다() async {
        let repository = MockTodoRepository()
        let viewModel = makeViewModel(repository: repository)

        await viewModel.add(title: "새 할 일")

        #expect(viewModel.todos.count == 1)
        #expect(viewModel.todos.first?.title == "새 할 일")
    }

    @Test
    func toggle_호출_시_완료_상태가_반영된다() async {
        let todo = Todo(title: "토글 대상")
        let repository = MockTodoRepository()
        await repository.seed([todo])
        let viewModel = makeViewModel(repository: repository)
        await viewModel.load()

        await viewModel.toggle(todo)

        #expect(viewModel.todos.first?.isCompleted == true)
    }

    @Test
    func delete_호출_시_todos에서_제거된다() async {
        let todo = Todo(title: "삭제 대상")
        let repository = MockTodoRepository()
        await repository.seed([todo])
        let viewModel = makeViewModel(repository: repository)
        await viewModel.load()

        await viewModel.delete(id: todo.id)

        #expect(viewModel.todos.isEmpty)
    }

    @Test
    func 저장소에서_에러가_나면_errorMessage가_설정된다() async {
        struct TestError: Error, LocalizedError {
            var errorDescription: String? { "테스트 에러" }
        }
        let repository = MockTodoRepository(shouldThrow: TestError())
        let viewModel = makeViewModel(repository: repository)

        await viewModel.load()

        #expect(viewModel.errorMessage == "테스트 에러")
    }
}
