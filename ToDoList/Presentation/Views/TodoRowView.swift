import SwiftUI

struct TodoRowView: View {
    let todo: Todo
    let onToggle: () -> Void

    var body: some View {
        Button(action: onToggle) {
            HStack(spacing: 12) {
                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(todo.isCompleted ? Color.accentColor : .secondary)
                Text(todo.title)
                    .font(.body)
                    .strikethrough(todo.isCompleted)
                    .foregroundStyle(todo.isCompleted ? .secondary : .primary)
                Spacer()
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel(todo.title)
        .accessibilityAddTraits(todo.isCompleted ? .isSelected : [])
    }
}

#Preview {
    List {
        TodoRowView(
            todo: Todo(title: "SwiftUI 공부하기"),
            onToggle: {}
        )
        TodoRowView(
            todo: Todo(title: "Claude Code 익히기", isCompleted: true),
            onToggle: {}
        )
    }
}
