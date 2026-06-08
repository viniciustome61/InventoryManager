import Foundation

class DashboardViewModel {
    
    // Simulando o seu estoque real para testarmos a interface
    private var watches: [WatchModel] = [
        WatchModel(id: UUID(), brand: "Garmin", modelName: "Forerunner 165", purchasePrice: 1200.0, salePrice: 1800.0, isInStock: true),
        WatchModel(id: UUID(), brand: "Coros", modelName: "Pace 3", purchasePrice: 1100.0, salePrice: 1600.0, isInStock: true)
    ]
    
    // A View vai pedir este texto já formatado em Reais (R$)
    var totalProfitText: String {
        // Soma o lucro de todos os relógios usando a propriedade computada que fizemos ontem
        let totalProfit = watches.reduce(0) { sum, watch in
            return sum + watch.profit
        }
        
        // Formatador automático do sistema da Apple para moeda
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        
        return formatter.string(from: NSNumber(value: totalProfit)) ?? "R$ 0,00"
    }
}
