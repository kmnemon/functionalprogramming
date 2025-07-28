//
//  Cut.swift
//  FP
//
//  Created by ke on 7/28/25.
//

//concurrency primitives
func cut(_ num: Int, _ callback: @escaping () ->Void ) -> () async -> Void {
    actor Counter {
        private var numFinished = 0
        private let target: Int
        private let callback: () -> Void
        
        init(target: Int, callback: @escaping () -> Void) {
            self.target = target
            self.callback = callback
        }
        
        func increment() {
            numFinished += 1
            print(numFinished)
            if numFinished == target {
                callback()
            }
        }
    }
    
    let counter = Counter(target: num, callback: callback)
    return {
        await counter.increment()
    }
}

func applyCut() async {
    let done = cut(3, {
        print("all done\n")
    })
    
    async let call1: Void = done()
    async let call2: Void = done()
    async let call3: Void = done()
    _ = await [call1, call2, call3]
}

