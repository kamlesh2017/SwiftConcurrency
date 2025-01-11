import PlaygroundSupport
import Foundation
PlaygroundPage.current.needsIndefiniteExecution = true

func abc() async -> String {
    sleep(1)
    return "abc"
}

func xyz() async -> String {
    sleep(5)
    return "xyz"
}

async let res1 = abc()
async let res2 = xyz()
print("kamlesh")
let (x, y) = await (res1, res2)
print(x, y)

