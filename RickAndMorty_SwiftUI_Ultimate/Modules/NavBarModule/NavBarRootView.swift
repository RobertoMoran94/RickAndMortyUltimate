import SwiftUI

struct NavBarRootView: View {
    @StateObject var viewModel: NavBarViewModel
    
    var body: some View {
        TabView(selection: Binding(get: { viewModel.selectedItem }, set: viewModel.didSelect)) {
            ForEach(viewModel.availableItems, id: \.rawValue) { item in
                Tab(item.rawValue, systemImage: item.systemImageName, value: item) {
                    makeDestination(for: item)
                        .font(.headline)
                }
            }
        }
    }
    
    @ViewBuilder
    private func makeDestination(for item: NavBarItem) -> some View {
        switch item {
        case .home:
            HomePageView()
        case .search:
            ListPageView()
        case .favorites:
            FavoritePageView()
        case .profile:
            ProfilePageView()
        }
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarRootView(viewModel: NavBarViewModel())
    }
}
