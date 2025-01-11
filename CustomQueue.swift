import UIKit

let q1 = DispatchQueue(label: "myQ", qos: .userInteractive, attributes: [.concurrent, .initiallyInactive], autoreleaseFrequency: .inherit, target: DispatchQueue.global(qos: .background))
q1.async {
    Thread.sleep(forTimeInterval: 1)
    print("kamlesh")
}

q1.async {
    print("kumar")
}

q1.async {
    print("sharma")
}

q1.activate()
