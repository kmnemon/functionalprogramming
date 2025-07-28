//
//  Cut.swift
//  FP
//
//  Created by ke on 7/28/25.
//

//working in single thread model, not use to swift async and await
func cut(_ num: Int, _ callback: @escaping () ->Void ) -> () async -> Void {
    var numFinished = 0
    return {
        numFinished += 1
        print(numFinished)
        if numFinished == num {
            callback()
        }
    }
}

func applyCut() async {
    let done = cut(3, {
        print("all done\n")
    })
    
    
    //    done()
    //    done()
    //    done()
    
    async let call1: Void = done()
    async let call2: Void = done()
    async let call3: Void = done()
    _ = await [call1, call2, call3]
}

