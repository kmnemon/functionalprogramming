//
//  CellValue.swift
//  FP
//
//  Created by ke on 7/30/25.
//

class Cell<T> {
    private var currentValue: T
    
    init(currentValue: T) {
        self.currentValue = currentValue
    }
    
    var value: T {
        get { currentValue }
    }
    
    func update(_ f: (T)->T) {
        var oldValue = currentValue
        var newValue = f(oldValue)
        currentValue = newValue
    }
}

func valueCell<T>(_ initialValue: T) -> Cell<T> {
    return Cell(currentValue: initialValue)
}
