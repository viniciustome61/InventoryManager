import Foundation
import SwiftData

@Model
class WatchModel {
    @Attribute(.unique) var id: UUID
    var brand: String
    var modelName: String
    var purchasePrice: Double
    var salePrice: Double
    var isInStock: Bool
    
    init(id: UUID = UUID(), brand: String, modelName: String, purchasePrice: Double, salePrice: Double, isInStock: Bool) {
        self.id = id
        self.brand = brand
        self.modelName = modelName
        self.purchasePrice = purchasePrice
        self.salePrice = salePrice
        self.isInStock = isInStock
    }
    
    var profit: Double {
        return salePrice - purchasePrice
    }
}
