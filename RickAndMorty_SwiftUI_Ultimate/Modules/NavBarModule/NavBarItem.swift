import Foundation

enum NavBarItem: String, Hashable, CaseIterable {
    case home = "Home"
    case search = "Search"
    case favorites = "Favorites"
    case profile = "Profile"
    
    var systemImageName: String {
        switch self {
            case .search:
                "magnifyingglass"
            case .favorites:
                "star"
            case .home:
                "house"
            case .profile:
                "person"
        }
    }
}
