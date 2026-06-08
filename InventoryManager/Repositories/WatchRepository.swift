import Foundation
import SwiftData

class WatchRepository {
    
    static let shared = WatchRepository()
    
    private var container: ModelContainer?
    private var context: ModelContext?
    
    private init() {
        do {
            container = try ModelContainer(for: WatchModel.self)
            if let container = container {
                context = ModelContext(container)
                seedInitialDataIfNeeded()
            }
        } catch {
            print("Erro ao inicializar o SwiftData: \(error)")
        }
    }
    
    func fetchWatches() -> [WatchModel] {
        guard let context = context else { return [] }
        let descriptor = FetchDescriptor<WatchModel>()
        do {
            return try context.fetch(descriptor)
        } catch {
            print("Erro ao buscar relógios no banco: \(error)")
            return []
        }
    }
    
    func addWatch(_ watch: WatchModel) {
        guard let context = context else { return }
        context.insert(watch)
        do {
            try context.save()
        } catch {
            print("Erro ao persistir o relógio: \(error)")
        }
    }
    
    private func seedInitialDataIfNeeded() {
        guard let context = context else { return }
        let descriptor = FetchDescriptor<WatchModel>()
        if let existingWatches = try? context.fetch(descriptor), existingWatches.isEmpty {
            let initialStock = [
                WatchModel(brand: "Garmin", modelName: "Forerunner 165", purchasePrice: 1200.0, salePrice: 1800.0, isInStock: true),
                WatchModel(brand: "Coros", modelName: "Pace 3", purchasePrice: 1100.0, salePrice: 1600.0, isInStock: true),
                WatchModel(brand: "Garmin", modelName: "Forerunner 255s", purchasePrice: 1500.0, salePrice: 2200.0, isInStock: false)
            ]
            for watch in initialStock {
                context.insert(watch)
            }
            try? context.save()
        }
    }
}
