import UIKit

var balance = 20000

enum BankingError: Error {
    case insufficientAmount
}

protocol Banking {
    func widrowAmount(amount: Int) throws
}

class ATM: Banking {
    func widrowAmount(amount: Int) throws {
        print("fetching amount from atm")
        guard amount <= balance else {
            throw BankingError.insufficientAmount
        }
        sleep(UInt32.random(in: 1...3))
        balance -= amount
        print("fetch amount from atm succesfully new balance is \(balance)")
    }
}

class NetBanking: Banking {
    func widrowAmount(amount: Int) throws {
        print("fetching amount from NetBanking")
        guard amount <= balance else {
            throw BankingError.insufficientAmount
        }
        sleep(UInt32.random(in: 1...3))
        balance -= amount
        print("fetch amount from NetBanking succesfully new balance is \(balance)")
    }
}

//let lock = NSLock()
let semaphore = DispatchSemaphore(value: 1)

DispatchQueue.global().async {
    do {
        //lock.lock()
        semaphore.wait()
        let atm = ATM()
        try atm.widrowAmount(amount: 15000)
        //lock.unlock()
        semaphore.signal()
    } catch BankingError.insufficientAmount {
        //lock.unlock()
        semaphore.signal()
        print("insufficient amount, fetch amount from Atm unsuccessful")
    } catch {
        //lock.unlock()
        semaphore.signal()
        print(error.localizedDescription)
    }
}

DispatchQueue.global().async {
    do {
        //lock.lock()
        semaphore.wait()
        let nb = NetBanking()
        try nb.widrowAmount(amount: 15000)
        //lock.unlock()
        semaphore.signal()
    } catch BankingError.insufficientAmount {
        //lock.unlock()
        semaphore.signal()
        print("insufficient amount, fetch amount from NetBanking unsuccessful")
    } catch {
        //lock.unlock()
        semaphore.signal()
        print(error.localizedDescription)
    }
}
