import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        Task {
            window = UIWindow(windowScene: windowScene)
            await registerContainer()
            let rootVC = await createMainViewController()
            window?.rootViewController = UINavigationController(rootViewController: rootVC)
            window?.makeKeyAndVisible()
        }
    }
    
    private func createMainViewController() async -> UIViewController {
        do {
            let mainViewModelFactory = try await DIContainer.shared.resolve(MainLoginViewModelFactory.self)
            let mainViewModel = mainViewModelFactory.create()
            return MainLoginViewController(viewModel: mainViewModel)
        }
        catch let error as DIError {
            print(error.description)
        } catch {
            print(error.localizedDescription)
        }
        return UIViewController()
    }
    
    private func registerContainer() async {
        do {
            await registerRepository()
            try await registerUseCase()
            try await registerViewModelFactory()
        }
        catch let error as DIError {
            print(error.description)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func registerRepository() async {
        await DIContainer.shared.register(UserLoginRepository.self, UserLoginRepositoryTest())
        await DIContainer.shared.register(UserLogoutRepository.self, UserLogoutRepositoryTest())
    }
    
    private func registerUseCase() async throws {
        let userLoginRepository = try await DIContainer.shared.resolve(UserLoginRepository.self)
        await DIContainer.shared.register(UserLoginUseCase.self,
                                          UserLoginUseCase(userLoginRepository: userLoginRepository))
        
        let userLogoutRepository = try await DIContainer.shared.resolve(UserLogoutRepository.self)
        await DIContainer.shared.register(UserLogoutUseCase.self,
                                          UserLogoutUseCase(userLogoutRepository: userLogoutRepository))
    }
    
    private func registerViewModelFactory() async throws {
        let userLoginUseCase = try await DIContainer.shared.resolve(UserLoginUseCase.self)
        await DIContainer.shared.register(MainLoginViewModel.self,
                                          MainLoginViewModel(userLoginUseCase: userLoginUseCase))
        
        let userLogoutUseCase = try await DIContainer.shared.resolve(UserLogoutUseCase.self)
        await DIContainer.shared.register(UserViewModelFactory.self,
                                          UserViewModelFactory(userLogoutUseCase: userLogoutUseCase))
    }


    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

