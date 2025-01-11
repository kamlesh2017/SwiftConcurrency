import Foundation

let semaphoreA = DispatchSemaphore(value: 1)
let semaphoreB = DispatchSemaphore(value: 1)

DispatchQueue.global().async {
    semaphoreA.wait()
    print("Thread 1: Locked semaphoreA")
    
    // Simulate some work
    for i in 1...10000000 {
        if i == 10000000 {
            print("Thread 1:", i)
        }
    }
    
    semaphoreB.wait()
    print("Thread 1: Locked semaphoreB")
    
    // Release semaphores
    semaphoreB.signal()
    semaphoreA.signal()
}

DispatchQueue.global().async {
    semaphoreB.wait()
    print("Thread 2: Locked semaphoreB")
    
    // Simulate some work
    for i in 1...10000000 {
        if i == 10000000 {
            print("Thread 2:", i)
        }
    }
    
    semaphoreA.wait()
    print("Thread 2: Locked semaphoreA")
    
    // Release semaphores
    semaphoreA.signal()
    semaphoreB.signal()
}
