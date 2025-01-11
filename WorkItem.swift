import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

class WorkItemDemo {
    
    var workItem: DispatchWorkItem?
    
    func printNumbers() {
        workItem = DispatchWorkItem {
            for i in 1...10 {
                if let workItem = self.workItem, workItem.isCancelled {
                    print("workItem cancelled")
                    break
                } else {
                    print(i)
                }
                sleep(1)
            }
        }
        
        DispatchQueue.global(qos: .default).async(execute: workItem!)
        
        DispatchQueue.global(qos: .default).asyncAfter(deadline: .now() + 2, execute: {
            self.workItem!.cancel()
        })
    
        
        workItem?.notify(queue: .main, execute: {
            if self.workItem?.isCancelled == false {
                print("task completed")
            } else {
                print("task not completed")
            }
            self.workItem = nil
        })
    }
}

let obj = WorkItemDemo()
obj.printNumbers()

