import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

struct Employees {
    func getEmployee(completion: @escaping ([String]) -> Void) {
        print("fetching employee")
        DispatchQueue.global().asyncAfter(deadline: .now() + 2, execute: {
            completion(["emp 1", "emp 2", "emp 3"])
        })
    }
}

struct Product {
    func getProduct(completion: @escaping ([String]) -> Void) {
        print("fetching product")
        DispatchQueue.global().asyncAfter(deadline: .now() + 4, execute: {
            completion(["product 1", "product 2", "product 3"])
        })
    }
}

let dispatchGroup = DispatchGroup()

let operation1 = BlockOperation {
    let empsObj = Employees()
    dispatchGroup.enter()
    empsObj.getEmployee { emps in
        print(emps)
        dispatchGroup.leave()
    }
    dispatchGroup.wait()
}

let operation2 = BlockOperation{
    let proObj = Product()
    dispatchGroup.enter()
    proObj.getProduct { products in
        print(products)
        dispatchGroup.leave()
    }
    dispatchGroup.wait()
}

let operations = [operation1, operation2]

for i in 0..<operations.count-1 {
    operations[i].addDependency(operations[i+1])
}

let q = OperationQueue()
q.addOperations(operations, waitUntilFinished: true)

print("All operations are completed")
