import Testing
import Foundation
@testable import TestApp

struct TodoRepositoryImplTests {

    @Test
    func 추가한_Todo를_조회할_수_있다() async throws {
        let dataSource = LocalTodoDataSource()
        let repository = TodoRepositoryImpl(dataSource: dataSource)
        let todo = Todo(title: "테스트")

        try await repository.add(todo)
        let fetched = try await repository.fetchAll()

        #expect(fetched.count == 1)
        #expect(fetched.first == todo)
    }

    @Test
    func 업데이트하면_변경_내용이_반영된다() async throws {
        let dataSource = LocalTodoDataSource()
        let repository = TodoRepositoryImpl(dataSource: dataSource)
        let original = Todo(title: "원본")
        try await repository.add(original)

        var updated = original
        updated.title = "수정됨"
        updated.isCompleted = true
        try await repository.update(updated)

        let fetched = try await repository.fetchAll()
        #expect(fetched.first?.title == "수정됨")
        #expect(fetched.first?.isCompleted == true)
    }

    @Test
    func 삭제하면_조회_결과에서_제외된다() async throws {
        let dataSource = LocalTodoDataSource()
        let repository = TodoRepositoryImpl(dataSource: dataSource)
        let todo = Todo(title: "삭제 대상")
        try await repository.add(todo)

        try await repository.delete(id: todo.id)

        let fetched = try await repository.fetchAll()
        #expect(fetched.isEmpty)
    }

    @Test
    func Entity와_DTO_변환_시_모든_필드가_보존된다() async throws {
        let dataSource = LocalTodoDataSource()
        let repository = TodoRepositoryImpl(dataSource: dataSource)
        let id = UUID()
        let date = Date(timeIntervalSince1970: 1_700_000_000)
        let original = Todo(id: id, title: "왕복 테스트", isCompleted: true, createdAt: date)

        try await repository.add(original)
        let fetched = try await repository.fetchAll()

        #expect(fetched.first?.id == id)
        #expect(fetched.first?.title == "왕복 테스트")
        #expect(fetched.first?.isCompleted == true)
        #expect(fetched.first?.createdAt == date)
    }
}
