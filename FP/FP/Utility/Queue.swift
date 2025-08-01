//
//  Callback.swift
//  FP
//
//  Created by ke Liu on 7/25/25.
//

struct Item<T, R> {
    var data: T
    var callback: (R) -> Void
}

func queue<T, R> (_ worker: @escaping (T, (R) -> Void) -> Void) -> (T, @escaping (R)->Void ) ->Void  {
    var queueItems: [Item<T, R>] = []
    var working = false
    
    func runNext() {
        if working { return }
        if queueItems.isEmpty { return }
        working = true
        
        guard !queueItems.isEmpty else { return }
        let item = queueItems.removeFirst()
        
        worker(item.data) { val in
            working = false
            item.callback(val)
            runNext()
        }
    }
    
    return { (_ data: T, _ callback: ((R)->Void)? ) in
        queueItems.append(Item(data: data, callback: callback ?? { _ in} ))
        runNext()
    }
}

func droppingQueue<T, R> (_ max: Int, _ worker: @escaping (T, (R) -> Void) -> Void) -> (T, @escaping (R)->Void ) ->Void  {
    var queueItems: [Item<T, R>] = []
    var working = false
    
    func runNext() {
        if working { return }
        if queueItems.isEmpty { return }
        working = true
        
        guard !queueItems.isEmpty else { return }
        let item = queueItems.removeFirst()
        
        worker(item.data) { val in
            working = false
            item.callback(val)
            runNext()
        }
    }
    
    return { (_ data: T, _ callback: ((R)->Void)? ) in
        queueItems.append(Item(data: data, callback: callback ?? { _ in} ))
        while queueItems.count > max {
            queueItems.removeFirst()
        }
        runNext()
    }
}

func calcWorker(_ item: Int, _ done: (Int)->Void) {
    //calc bussiness
    let total = 100
    done(total)
}

var updateTotalQueue = droppingQueue(1, calcWorker)
