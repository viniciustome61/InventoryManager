import Foundation

struct WatchModel {
    let id: UUID
    let brand: String       // Ex: "Garmin", "Coros"
    let modelName: String   // Ex: "Forerunner 165", "Pace 3"
    let purchasePrice: Double
    let salePrice: Double
    let isInStock: Bool
    
    // Propriedade computada que já calcula o lucro automaticamente!
    var profit: Double {
        return salePrice - purchasePrice
    }
}
