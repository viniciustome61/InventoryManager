import Foundation

class DashboardViewModel {
    var totalProfitText: String {
        let watches = WatchRepository.shared.fetchWatches()
        let totalProfit = watches.reduce(0) { sum, watch in
            return sum + watch.profit
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        
        return formatter.string(from: NSNumber(value: totalProfit)) ?? "R$ 0,00"
    }
}
