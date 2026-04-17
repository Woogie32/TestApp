import SwiftUI

struct AddTodoView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var viewModel: TodoListViewModel

    @State private var title: String = ""
    @FocusState private var isTitleFocused: Bool

    private var trimmedTitle: String {
        title.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("할 일 제목", text: $title)
                        .font(.body.weight(.medium))
                        .focused($isTitleFocused)
                        .submitLabel(.done)
                        .onSubmit(submit)
                }
            }
            .navigationTitle("할 일 추가")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("취소") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("추가", action: submit)
                        .disabled(trimmedTitle.isEmpty)
                }
            }
            .onAppear { isTitleFocused = true }
        }
    }

    private func submit() {
        let titleToAdd = trimmedTitle
        guard !titleToAdd.isEmpty else { return }
        Task {
            await viewModel.add(title: titleToAdd)
            dismiss()
        }
    }
}

@MainActor
private func makePreviewViewModel() -> TodoListViewModel {
    let dataSource = LocalTodoDataSource()
    let repository = TodoRepositoryImpl(dataSource: dataSource)
    return TodoListViewModel(
        fetchTodos: FetchTodosUseCase(repository: repository),
        addTodo: AddTodoUseCase(repository: repository),
        toggleTodo: ToggleTodoUseCase(repository: repository),
        deleteTodo: DeleteTodoUseCase(repository: repository)
    )
}

#Preview("Light") {
    AddTodoView(viewModel: makePreviewViewModel())
}

#Preview("Dark") {
    AddTodoView(viewModel: makePreviewViewModel())
        .preferredColorScheme(.dark)
}
