//
//  Cut.swift
//  FP
//
//  Created by ke on 7/28/25.
//

func cut(_ num: Int, _ callback: @escaping ()->Void ) -> () -> Void {
    var numFinished = 0
    return {
        numFinished += 1
        if numFinished == num {
            callback()
        }
    }
}

func applyCut() {
    var done = cut(3, {
        print("all done\n")
    })
}
