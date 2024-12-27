import Foundation

class NavBarViewModel: ObservableObject {
    @Published var availableItems: [NavBarItem] = NavBarItem.allCases
    @Published private(set) var selectedItem: NavBarItem = .home
    
    func didSelect(item: NavBarItem) {
        self.selectedItem = item
    }
}
