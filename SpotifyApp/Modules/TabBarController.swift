import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let home = UINavigationController(rootViewController: HomeViewController())
        let search = UINavigationController(rootViewController: SearchViewController())
        let library = UINavigationController(rootViewController: LibraryViewController())
        
        home.navigationBar.prefersLargeTitles = true
        search.navigationBar.prefersLargeTitles = true
        library.navigationBar.prefersLargeTitles = true
        
        home.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        search.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        library.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 2)
        setViewControllers([home, search, library], animated: false)
    }
}
