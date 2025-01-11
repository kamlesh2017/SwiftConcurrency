import PlaygroundSupport
import Foundation
PlaygroundPage.current.needsIndefiniteExecution = true

DispatchQueue.global().sync {
    print(Thread.isMainThread, 1)
    DispatchQueue.global().async {
        print(Thread.isMainThread, 2)
    }
}
