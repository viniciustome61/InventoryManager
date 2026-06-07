import UIKit

class DashboardViewController: UIViewController {
    
    // MARK: - 1. UI Elements (Criando os componentes)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Visão Geral"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profitCard: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen.withAlphaComponent(0.1)
        view.layer.cornerRadius = 16
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profitTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Lucro Estimado"
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let profitValueLabel: UILabel = {
        let label = UILabel()
        label.text = "R$ 0,00" // Em breve ligaremos isto ao seu WatchModel real
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground // Adapta-se automaticamente ao Dark/Light mode
        
        setupHierarchy()
        setupConstraints()
    }
    
    // MARK: - 2. Hierarchy (Adicionando ao ecrã)
    
    private func setupHierarchy() {
        view.addSubview(titleLabel)
        view.addSubview(profitCard)
        
        // Estes textos ficam dentro do cartão verde
        profitCard.addSubview(profitTitleLabel)
        profitCard.addSubview(profitValueLabel)
    }
    
    // MARK: - 3. Auto Layout (Definindo posições e tamanhos)
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Título Principal
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // Cartão de Lucro
            profitCard.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            profitCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            profitCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            profitCard.heightAnchor.constraint(equalToConstant: 100),
            
            // Textos dentro do Cartão
            profitTitleLabel.topAnchor.constraint(equalTo: profitCard.topAnchor, constant: 16),
            profitTitleLabel.leadingAnchor.constraint(equalTo: profitCard.leadingAnchor, constant: 16),
            
            profitValueLabel.bottomAnchor.constraint(equalTo: profitCard.bottomAnchor, constant: -16),
            profitValueLabel.leadingAnchor.constraint(equalTo: profitCard.leadingAnchor, constant: 16)
        ])
    }
}
