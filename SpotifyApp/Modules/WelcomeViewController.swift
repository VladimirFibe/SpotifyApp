import UIKit

final class WelcomeViewController: UIViewController {
    private lazy var signInButton: UIButton = {
        $0.setTitle("Sign In with Spotify", for: .normal)
        $0.addTarget(self, action: #selector(didTapSignIn), for: .primaryActionTriggered)
        return $0
    }(UIButton(type: .system))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signInButton)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 20, y: view.height - 50 - view.safeAreaInsets.bottom, width: view.widht - 49, height: 50)
    }
    
    @objc private func didTapSignIn() {
        let controller = AuthViewController()
        controller.comletionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        
    }
}
