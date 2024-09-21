import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        start()
    }
    
    func start() {
        setRootViewController(makeAuth())
//        if AuthManager.shared.isSignedIn {
//            setRootViewController(makeTabbar())
//        } else {
//            setRootViewController(makeAuth())
//        }
    }
    
    func setRootViewController(_ controller: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = controller
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    private func makeAuth() -> UIViewController {
        UINavigationController(rootViewController: AuthViewController())
    }
    
    private func makeTabbar() -> UIViewController {
        return AuthViewController()
    }
}

