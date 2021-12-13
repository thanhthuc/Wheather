import UIKit

//var greeting = "Hello, playground"
//
//
//// MARK: Networking API reduce request & replay operator,
//// MARK: IN Practice: Search API simulate and validation simulate for FORM TEXTFIELD
//
//
//
//// MARK: SOLID
//
//// 1. S => Single responseability
//
//func calculateAgeWithName(name: String) -> Int {
//    if name == "Tu" {
//        //
//        return 110
//    } else if name == "Thuc" {
//        //
//        return 109
//    }
//    return Int.max
//}
//
//
//// 2. O => Open/close => Close: Khong chinh sua class cha, Open: co the mo rong class cha
//
//
//class TeacherGeneral {
//    func teachMath() {}
//    func teachListerature() {}
//    // func teachRuleKhanQuangDo() {}
//}
//// Vi pham close rule
//
///*
// Open: co the mo rong nhung khong chinh sua class cha
// */
//
//class Teacher: TeacherGeneral {
//
//    override func teachMath() {
//
//    }
//
//    override func teachListerature() {
//
//    }
//}
//
//class TeacherTraing: TeacherGeneral {
//
//    override func teachMath() {
//
//    }
//
//    override func teachListerature() {
//
//    }
//
//
//}
//
//extension TeacherGeneral {
//    func teachRuleKhanQuangDo() {
//
//    }
//}
//
//// 3. L
//// LIKSKOP SUBSTITION
///*
//
// */
//class Base {
//    func generate(with name: String) -> String {
//        if name == "Phuoc" {
//            return "Bilion Dollar" // Ti phu
//        } else if name == "Thuc" {
//            return "Bilion Dollar" + "Wife understand"
//        }
//        return "Nothing"
//    }
//}
//
//class A:Base {
//    override func generate(with name: String) -> String {
//        return super.generate(with: name)
//    }
//}
//
//class C: A {
//    override func generate(with name: String) -> String {
//        return super.generate(with: name)
//    }
//}
//
//// parent
//var base: Base = Base()
//print(base.generate(with: "Tu"))
//
//// child
//var a: A = A()
//let result = a.generate(with: "Phuoc")
//print(result)
//
//func getInputThenGenerateData(input: String) -> String {
//
//    return input
//}
//
//getInputThenGenerateData(input: base.generate(with: ""))
//
//getInputThenGenerateData(input: a.generate(with: ""))
//
//// Han che dung base truc tiep
//class BaseRepository {
//
//    // Should Not change here because this is core core logic
//    func fetchDataFromDataModel(isConnect: Bool) -> String {
//        if isConnect {
//            // Mock data from data base
//            return "Core data"
//        } else {
//            return "File data"
//        }
//    }
//
//
//}
//
//class ClientRepository: BaseRepository {
//
//    override func fetchDataFromDataModel(isConnect: Bool) -> String {
//        return super.fetchDataFromDataModel(isConnect: isConnect)
//    }
//
//    func fectchSpecialData() -> String {
//        return "Special data"
//    }
//}
//
//
//var dataFetched: ClientRepository = ClientRepository()
//let resultCoreData = dataFetched.fetchDataFromDataModel(isConnect: true)
//print(resultCoreData)
//
//// MARK: Nguyen ly Interface segregation
//protocol AnimalViewModelType {
//    func eat()
//    func ia()
//}
//
//protocol Flyable {
//    func fly()
//}
//
//class Fish: AnimalViewModelType {
//    func eat() {
//
//    }
//
//    func ia() {
//
//    }
//
//}
//
//class Chimbocau: AnimalViewModelType, Flyable {
//    func eat() {
//
//    }
//
//    func ia() {
//
//    }
//
//    func fly() {
//
//    }
//}
//
//// DI: Denpendency inversion # Dependency injection
//
///*
// High-level modules should not depend on low-level modules. Both should depend on abstractions.
// Abstractions should not depend on details. Details should depend on abstractions.
// */
//
//protocol ListViewModelProtocol {
//    func createList() -> [Int]
//}
//
//class ListViewModel: ListViewModelProtocol {
//    func createList() -> [Int] {
//        return [1,2,3]
//    }
//}
//
//class ViewController {
//
//    var viewModel: ListViewModelProtocol!
//
//    func viewDidLoad() {
//        viewModel = ListViewModel()
//
//    }
//
//    func bindData() {
//        let list = viewModel.createList()
//        print(list)
//    }
//
//}
//
//let v = ViewController()
//v.viewDidLoad()
//v.bindData()

/////////=================Tu==============

// SOLID

// S: Single responsebility


/*
 2 cong viec trong 1 function
 */
func calculateAge(name: String) -> Int {
    var calculateMoney = 0
    if name == "Duy Tu" {
        calculateMoney = 100
    } else {
        calculateMoney = 200
    }
    
    if name == "Duy Tu" {
        return 25
    }
    else if name == "Thuc" {
        return 28
    }
    return 100
}

print(calculateAge(name: "Duy Tu"))

class DataBaseFetch {
    
    func fetchCoreData() {
        
    }
    
    func fillData() {
        
    }
    
    func callAPIRemote() {
        
    }
}

// 2. Open/Close: 1 class co the extend va khong dc chinh sua class cha

//class Animal {
//    func run() {
//
//    }
//
//    func eat() {
//
//    }
//}
//
//class Ga: Animal {
//    override func run() {
//
//    }
//
//    override func eat() {
//
//    }
//}
//
//class Ca: Animal {
//
//    override func run() {
//
//    }
//
//    override func eat() {
//
//    }
//
//    func boi() {
//
//    }
//
//}
//
//extension Animal {
//
//}
//
//
//let ca: Ca = Ca()
//ca.boi()

// 3. LISKOP SUBSTITUTION
/*
 Con cung co the thay the cho cha:
 Derived classes must be substitutable for their base classes.
 
 implement những tính năng của super class thì không nên làm thay đổi các hành vi của super class đó.
 */

class Animal {
    func run(isEnable: Bool) {
        if isEnable {
            print("Can run")
        } else {
            print("Can not run")
        }
    }
}

class Dog: Animal {
    
    override func run(isEnable: Bool) {
        super.run(isEnable: isEnable)
        print("Additional")
    }
}



let baseAnimal = Animal()
baseAnimal.run(isEnable: true)
let dog = Dog()
dog.run(isEnable: true)


protocol VehicleProtocol {
    func move()
}
 
protocol TankCapability {
    var tankCapicity: Float { get }
    func setTankCapacity()
}


class Car: VehicleProtocol, TankCapability {
    
    var tankCapicity: Float = 0
    
    func setTankCapacity() {
        
    }
    
    func move() {

    }
}

class Bycicle: VehicleProtocol {
    func move() {
        
    }
}

extension VehicleProtocol {
    func move() {
        print("ABCD")
    }
}

let car = Car()
car.move()

// Nguyen ly Interface segregation
/*
 khong can quan tam den nhung thu no ko can thiet
 */

protocol ThucVat {
    func hutnuoc()
    func rahoa()
}

protocol CotheAnThit {
    func anthit()
}

class CayAnThitA: ThucVat, CotheAnThit {
    func anthit() {
        
    }
    
    func hutnuoc() {
        
    }
    func rahoa() {
        
    }
    
}

class XuongRong: ThucVat {
    
    func hutnuoc() {
        
    }
    
    func rahoa() {
        
    }
}

// D: Dependency inversion

/*
 Depend on abstractions, not on concretions (Details)

 A. High-level modules should not depend on low-level modules. Both should depend on abstractions.

 B. Abstractions should not depend on details. Details should depend on abstractions.
 
 */

protocol ViewModelProtocol {
    func createData() -> [Int]
}

class ViewModel: ViewModelProtocol {
    func createData() -> [Int] {
        return [1,2,3,4,5]
    }
}

class ViewControllerA {
    
    private var viewModel: ViewModelProtocol
    
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    func binding() {
        print(viewModel.createData())
    }
}


let viewModel = ViewModel() // unit test no
let vcA = ViewControllerA(viewModel: viewModel)
vcA.binding()
// depencypendency inversion => phu thuoc protocol/ abtract
// depencypendency injection => inject property tu ben ngoai qua init hoac property
