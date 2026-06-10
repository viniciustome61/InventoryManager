import UIKit

class InventoryViewController: UIViewController {
    
    
    private let viewModel = InventoryViewModel()
    
    // MARK: - 1. UI Elements
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        // Registamos uma célula padrão do sistema para podermos usá-la mais tarde
        table.register(UITableViewCell.self, forCellReuseIdentifier: "WatchCell")
        return table
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Estoque"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setupHierarchy()
        setupConstraints()
        
        // <-- Adicione estas duas linhas
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addWatchTapped)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Recarrega os dados do banco e atualiza a interface toda vez que a tela aparece
        tableView.reloadData()
    }
    
    // MARK: - 2. Hierarchy
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    // MARK: - 3. Auto Layout
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // A lista vai preencher o ecrã inteiro
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    @objc private func addWatchTapped() {
            let addVC = AddWatchViewController()
            // Envolvemos a tela num NavigationController para ela ter a barra no topo
            let navController = UINavigationController(rootViewController: addVC)
            // Apresenta como um modal (deslizando de baixo para cima)
            present(navController, animated: true)
        }
}

// MARK: - UITableViewDataSource & Delegate
extension InventoryViewController: UITableViewDataSource, UITableViewDelegate {
    
    // 1. Quantas linhas?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    // 2. O que tem dentro de cada linha?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WatchCell", for: indexPath)
        let watch = viewModel.watch(at: indexPath.row)
        
        // Configuração moderna de células da Apple
        var content = cell.defaultContentConfiguration()
        content.text = "\(watch.brand) \(watch.modelName)"
        content.secondaryText = "Venda: R$ \(watch.salePrice)"
        
        // Se estiver em estoque, o ícone fica verde. Se não, vermelho.
        content.image = UIImage(systemName: "applewatch")
        content.imageProperties.tintColor = watch.isInStock ? .systemGreen : .systemRed
        
        cell.contentConfiguration = content
        return cell
        }
    
    // 3. Habilita o gesto de arrastar para apagar
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            // Verifica se a ação do usuário foi realmente o gesto de deletar (botão vermelho)
            if editingStyle == .delete {
                // 1. Avisa a ViewModel para apagar do banco de dados
                viewModel.deleteWatch(at: indexPath.row)
                
                // 2. Remove a linha da tela com uma animação suave
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
}
