//
//  JustOnce.swift
//  FP
//
//  Created by ke on 7/29/25.
//

actor CallOnce<T> {
    private var alreadyCalled = false
    private let action: (T) -> Void
    
    init(action: @escaping (T) -> Void) {
        self.action = action
    }
    
    func call(_ arg: T) async {
        if !alreadyCalled {
            alreadyCalled = true
            action(arg)
        }
    }
}


func JustOne<T>(_ action: @escaping (T)->Void) -> (T) async ->Void {
    let callOnce = CallOnce(action: action)
    
    return { arg in
        await callOnce.call(arg)
    }
}
