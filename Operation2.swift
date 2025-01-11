import Foundation

let operationQueue = OperationQueue()
operationQueue.maxConcurrentOperationCount = 1

let operation1 = BlockOperation {
    print("Operation 1 started")
    sleep(2)
    print("Operation 1 completed")
    print(Thread.isMainThread)
    
    DispatchQueue.main.async {
        print("kamlesh")
    }
}

operation1.addExecutionBlock {
    print("Operation 2 started")
    sleep(1)
    print("Operation 2 completed")
}

operation1.addExecutionBlock {
    print("Operation 3 started")
    sleep(1)
    print("Operation 3 completed")
}

operationQueue.addOperation(operation1)
operationQueue.waitUntilAllOperationsAreFinished()
print("All operation completed")

//DispatchQueue.global().async {
//    operation1.start()
//}
//operation1.waitUntilFinished()

//operation1.start()
//print("All operation completed")

for i in 0...10000000 {
    if i == 1000000 {
        print(i)
    }
}
