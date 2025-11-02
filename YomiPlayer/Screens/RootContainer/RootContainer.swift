import SwiftUI
import Navigation
import VideoLibrary

struct RootContainer: View {
    @State private var router = Router(level: 0, identifierTab: nil)

    var body: some View {
        TabView(selection: $router.selectedTab) {
            Tab(
                "Library",
                systemImage: "tray.full",
                value: TabDestination.library
            ) {
                NavigationContainer(parentRouter: router, tab: .library) {
                    LibraryScreen()
                }
            }
            Tab(
                "Words",
                systemImage: "character.book.closed",
                value: TabDestination.words
            ) {
                NavigationContainer(parentRouter: router, tab: .words) {
                    WordsScreen()
                }

            }
            Tab(
                "Settings",
                systemImage: "gearshape",
                value: TabDestination.settings
            ) {
                NavigationContainer(parentRouter: router, tab: .settings) {
                    SettingsScreen()
                }

            }
        }
    }
}

#Preview {
    RootContainer()
}
