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
}
