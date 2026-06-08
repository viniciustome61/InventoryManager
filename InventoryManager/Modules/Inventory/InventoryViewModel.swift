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
}
