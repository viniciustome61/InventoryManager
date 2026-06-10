import Foundation

class InventoryViewModel {
    private var watches: [WatchModel] {
        return WatchRepository.shared.fetchWatches()
    }
    
    var numberOfRows: Int {
        return watches.count
    }
    
    func watch(at index: Int) -> WatchModel {
        return watches[index]
    }
    
    // Repassa a ordem de exclusão para o Repositório Central
        func deleteWatch(at index: Int) {
            let watchToDelete = watches[index]
            WatchRepository.shared.deleteWatch(watchToDelete)
        }
}
