import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        if (scene as? UIWindowScene) != nil { return }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        let coreDataManager = CoreDataManager()
        coreDataManager.save()
    }
}
