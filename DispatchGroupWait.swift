import Foundation

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

let empsObj = Employees()

dispatchGroup.enter()
empsObj.getEmployee { emps in
    print(emps)
    dispatchGroup.leave()
}

dispatchGroup.wait()

let proObj = Product()
dispatchGroup.enter()
proObj.getProduct { products in
    print(products)
    dispatchGroup.leave()
}

dispatchGroup.wait()

print("products and employees are fetched successful")

//let result = dispatchGroup.wait(timeout: DispatchTime.now() + 3)
//
//if result == .timedOut {
//    print("products and employees are not fetched successful")
//} else {
//    print("products and employees are fetched successful")
//}
