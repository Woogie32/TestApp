# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build & Test

This is a SwiftUI iOS app built with Xcode. Use the `BuildProject` MCP tool to build. Use `RunAllTests` or `RunSomeTests` MCP tools to run tests.

- Tests use the Swift Testing framework (`import Testing`, `@Test`, `#expect(...)`)
- Unit tests: `TestAppTests` target
- UI tests: `TestAppUITests` target

## Architecture

Standard single-view SwiftUI app:
- `TestAppApp.swift` — App entry point (`@main`), sets up `WindowGroup` with `ContentView`
- `ContentView.swift` — Main view
