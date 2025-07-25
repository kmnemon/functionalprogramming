//
//  Callback.swift
//  FP
//
//  Created by ke Liu on 7/25/25.
//

func queue<T> (_ worker: @escaping (T, () -> Void) -> Void) -> (T) ->Void  {
    var items: [T] = []
    
    func runNext() {
        guard !items.isEmpty else { return }
        let item = items.removeFirst()
        
        worker(item) {
            runNext()
        }
    }
    
    return { (_ data: T) in
        items.append(data)
        runNext()
    }
}

func calcWorker(_ item: Int, _ done: ()->Void) {
    //calc bussiness
    done()
}

var updateTotalQueue = queue(calcWorker)
