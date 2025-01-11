import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class SomeClass {
    let operation = BlockOperation()
    
    func doSomething() {
        operation.addExecutionBlock({
            print(Thread.isMainThread, 1)
            print("kamlesh")
        })

        operation.addExecutionBlock({
            print(Thread.isMainThread, 2)
            sleep(2)
            print(self.operation.isCancelled)
            if self.operation.isCancelled {
                print("hehe")
            } else {
                print("Kumar")
            }
        })

        operation.addExecutionBlock({
            print("Sharma")
        })
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1, execute: {
            self.operation.cancel()
        })

        operation.start()
    }
}


let s = SomeClass()
s.doSomething()

for i in 0...10000000 {
    if i == 10000000 {
        print(i)
    }
}

