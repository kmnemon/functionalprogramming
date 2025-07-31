//
//  CellValue.swift
//  FP
//
//  Created by ke on 7/30/25.
//

class Cell<T: Equatable> {
    private var currentValue: T
    private var watchers: [(T)->Void] = []
    
    init(val: T) {
        self.currentValue = val
    }
    
    init(currentValue: T, watchers: [ (T) -> Void]) {
        self.currentValue = currentValue
        self.watchers = watchers
    }
    
    var value: T {
        get { currentValue }
    }
    
    var ws: [(T)->Void] {
        get { self.watchers }
    }
    
    func update(_ f: (T)->T) {
        let oldValue = currentValue
        let newValue = f(oldValue)
        if oldValue != newValue {
            currentValue = newValue
            watchers.forEach { watcher in
                watcher(newValue)
            }
        }
    }
    
    func addWatcher(_ f: @escaping (T)->Void) {
        watchers.append(f)
    }
}

func valueCell<T: Equatable>(_ initialValue: T) -> Cell<T> {
    return Cell(val: initialValue)
}

func formulaCell<T: Equatable, R: Equatable>(_ upstreamCell: Cell<T>, _ f: @escaping (T)->R) -> Cell<R> {
    var myCell = valueCell(f(upstreamCell.value))
    upstreamCell.addWatcher { newUpstreamValue in
        myCell.update { currentValue in
            return f(newUpstreamValue)
        }
    }
    
    return Cell(currentValue: myCell.value, watchers: myCell.ws)
}
