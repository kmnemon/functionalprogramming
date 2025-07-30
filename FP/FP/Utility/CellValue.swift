//
//  CellValue.swift
//  FP
//
//  Created by ke on 7/30/25.
//

class Cell<T: Equatable> {
    private var currentValue: T?
    private var watchers: [(T?)->Void] = []
    
    init(currentValue: T?) {
        self.currentValue = currentValue
    }
    
    var value: T? {
        get { currentValue }
    }
    
    func update(_ f: (T?)->T?) {
        var oldValue = currentValue
        var newValue = f(oldValue)
        if oldValue != newValue {
            currentValue = newValue
            watchers.forEach { watcher in
                watcher(newValue)
            }
        }
    }
    
    func addWatcher(_ f: @escaping (T?)->Void) {
        watchers.append(f)
    }
}

func valueCell<T>(_ initialValue: T?) -> Cell<T> {
    return Cell(currentValue: initialValue)
}
