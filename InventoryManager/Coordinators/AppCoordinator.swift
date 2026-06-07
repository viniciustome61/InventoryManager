import UIKit

class AppCoordinator {
    var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        // 1. Criamos a TabBar principal
        let tabBarController = UITabBarController()
        
        // 2. Instanciamos os nossos ecrãs
        let dashboardVC = DashboardViewController()
        let inventoryVC = InventoryViewController()
        
        // 3. Colocamos cada ecrã dentro de um NavigationController (essencial para podermos abrir detalhes dos relógios depois)
        let dashboardNav = UINavigationController(rootViewController: dashboardVC)
        let inventoryNav = UINavigationController(rootViewController: inventoryVC)
        
        // 4. Desenhamos os ícones e títulos da TabBar na parte inferior
        dashboardNav.tabBarItem = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "chart.bar.fill"), tag: 0)
        inventoryNav.tabBarItem = UITabBarItem(title: "Stock", image: UIImage(systemName: "shippingbox.fill"), tag: 1)
        
        // 5. Inserimos os ecrãs na TabBar
        tabBarController.viewControllers = [dashboardNav, inventoryNav]
        
        // 6. Definimos a TabBar como a raiz da nossa janela e mostramos no ecrã
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}
