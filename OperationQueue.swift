import Foundation

let operation1 = BlockOperation()

operation1.addExecutionBlock {
    print("fetch employee data from local storage")
    sleep(2)
    if operation1.isCancelled {
        print("operation1 is canclled")
        return
    }
    print("pushed employee data to server")
}

let operation2 = BlockOperation()

operation2.addExecutionBlock {
    print("fetch user data from local storage")
    sleep(2)
    print("pushed user data to server")
}

operation1.addDependency(operation2)

let q = OperationQueue()
q.qualityOfService = .default


//q.addOperation(operation1)
//q.addOperation(operation2)

q.addOperation({
    sleep(1)
    q.isSuspended = true
    sleep(10)
    print("kamlesh")
    q.isSuspended = false
    sleep(1)
    //operation1.cancel()
})


//q.waitUntilAllOperationsAreFinished()

q.addOperations([operation1, operation2], waitUntilFinished: true)

let q1 = OperationQueue()
q1.addOperation {
    print("q1.addOperation")
}
