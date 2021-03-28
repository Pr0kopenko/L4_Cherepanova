//
//  main.swift
//  L4_Cherepanova
//
//  Created by Виктория Черепанова on 23.03.2021.
//

import Foundation

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.


enum Transmission {
    case manual, auto
}

enum WindowsState: String {
    case open = "Открыты"
    case closed = "Закрыты"
}

enum RoofState {
    case raised, lowered
}

enum CarAction {
    case openWindows
    case closeWindows
    case loadTrunk (cargo: Double)
    case unloadTrunk (cargo: Double)
    case hookedTrunk
    case unhookedTrunk
    case roofRaised
    case roofLowered
}

class Car {
    let brand: String
    let releaseYear: Int
    let transmission: Transmission
    var windowsState: WindowsState
    var mileage: Int {
        didSet {
            if mileage > oldValue  {
                print("Автомобиль проехал еще \(mileage - oldValue) км")
            }
        }
    }
    static var carCount = 0

    init (brand: String, releaseYear: Int, transmission: Transmission, windowsState: WindowsState, mileage: Int) {
        self.brand = brand
        self.releaseYear = releaseYear
        self.transmission = transmission
        self.windowsState = windowsState
        self.mileage = mileage
        Car.carCount += 1
    }

    deinit {
            Car.carCount -= 1
        }


    static func countInfo(){
            print("Выпущено \(self.carCount) автомобилей")
        }

    func carChange (action: CarAction) {
        switch action {
        case .openWindows:
            if windowsState == .open {
                print("Окна и так открыты")
            } else {
                windowsState = .open
                print("Окна открыты")
            }

        case .closeWindows:
            if windowsState == .closed {
                print("Окна и так закрыты")
            } else {
                windowsState = .closed
                print("Окна закрыты")
            }
        default:
            print("Невозможно совершить запрошенное действие для этого автомобиля")
        }
    }
    
    func printCarInfo () {
        print("____________________")
        print(self.brand)
        print("Год выпуска: \(self.releaseYear)")
        print("Трансмиссия: \(self.transmission)")
        print("Окна \(self.windowsState.rawValue)")
        print("Пробег: \(self.mileage) км")
        
    }

}

class TrunkCar: Car {

    var trunkState: Bool
    let trunkVolume: Double
    var trunkVolumeFilled: Double

    init (brand: String, releaseYear: Int, transmission: Transmission, windowsState: WindowsState, mileage: Int, trunkState: Bool, trunkVolume: Double, trunkVolumeFilled: Double) {
        self.trunkState = trunkState
        self.trunkVolume = trunkVolume
        self.trunkVolumeFilled = trunkVolumeFilled
        super.init(brand: brand, releaseYear: releaseYear, transmission: transmission, windowsState: windowsState, mileage: mileage)
    }

    override func carChange (action: CarAction) {
        switch action {
        case .openWindows:
            if windowsState == .open {
                print("Окна и так открыты")
            } else {
                windowsState = .open
                print("Окна открыты")
            }
        case .closeWindows:
            if windowsState == .closed {
                print("Окна и так закрыты")
            } else {
                windowsState = .closed
                print("Окна закрыты")
            }
        case .hookedTrunk:
            if trunkState == true {
                print("Багажник уже прицеплен")
            } else {
                trunkState = true
                print("Багажник прицеплен")
            }
        case .unhookedTrunk:
            if trunkState == true {
                trunkState = false
                print("Багажник отцеплен")
            } else {
                print("Багажник уже отцеплен")
            }
        case .loadTrunk (let cargo):
            if trunkState == false {
                print("Невозможно положить в автомобиль груз, пока багажник отцеплен")
            }else{
                if cargo <= trunkVolume {
                    trunkVolumeFilled += cargo
                    print("В автомобиль загружено \(cargo) кг груза")
                }else{
                    print("В автомобиль нельзя положить столько груза, уберите \(cargo - trunkVolume) кг")
                }
            }
        case .unloadTrunk (let cargo):
            if cargo <= trunkVolumeFilled {
                trunkVolumeFilled = trunkVolumeFilled - cargo
                print("Из автомобиля выгружено \(cargo) кг груза")
            }else{
                print("Невозможно выгрузить из автомобиля \(cargo) кг. В автомобиле всего \(trunkVolumeFilled) кг  груза")
            }
        default:
            print("Невозможно совершить запрошенное действие для этого автомобиля")
        }
    }
    override func printCarInfo () {
        super.printCarInfo()
        print("Объём багажника: \(self.trunkVolume) кг")
        print("Заполненность багажника: \(self.trunkVolumeFilled) кг")
        print("Багажник \(self.trunkState == true ? "прицеплен" : "отцеплен")")
    }

}


class SportCar: Car {

    var roofState: RoofState
    let gasMileage: Double

    init (brand: String, releaseYear: Int, transmission: Transmission, windowsState: WindowsState, mileage: Int, roofState: RoofState, gasMileage: Double) {
        self.roofState = roofState
        self.gasMileage = gasMileage
        super.init(brand: brand, releaseYear: releaseYear, transmission: transmission, windowsState: windowsState, mileage: mileage)
    }

    override func carChange (action: CarAction) {
        switch action {
        case .openWindows:
            if windowsState == .open {
                print("Окна и так открыты")
            } else {
                windowsState = .open
                print("Окна открыты")
            }
        case .closeWindows:
            if windowsState == .closed {
                print("Окна и так закрыты")
            } else {
                windowsState = .closed
                print("Окна закрыты")
            }
        case .roofRaised:
            if roofState == .raised {
                print("Крыша уже поднята,  ничего не изменится")
            } else {
                roofState = .raised
                print("Крыша кабриолета поднята")
            }

        case .roofLowered:
            roofState = .lowered
            print("Крыша кабриолета опущена")
        default:
            print("Невозможно совершить запрошенное действие для этого автомобиля")
        }
    }

    override func printCarInfo () {
        super.printCarInfo()
        print("Расход бензина: \(self.gasMileage) л на 100 км")
        print("Крыша автомобиля \(self.roofState == .raised ? "поднята" : "опущена")")
        print("____________________")
    }
    
}


var car1 = Car (brand: "Polo", releaseYear: 2010, transmission: .auto, windowsState: .closed, mileage: 200)
var car2 = Car (brand: "Golf", releaseYear: 2001, transmission: .manual, windowsState: .closed, mileage: 0)


var trunkСar1 = TrunkCar (brand: "Jeep", releaseYear: 2010, transmission: .auto, windowsState: .open, mileage: 100, trunkState: true, trunkVolume: 2000.0, trunkVolumeFilled: 0.0)
var trunkCar2 = TrunkCar (brand: "Toyota", releaseYear: 2000, transmission: .auto, windowsState: .open, mileage: 0, trunkState: false, trunkVolume: 2100.0, trunkVolumeFilled: 100.0)

var sportCar1 = SportCar (brand: "Subaru", releaseYear: 2005, transmission: .auto, windowsState: .closed, mileage: 100, roofState: .lowered, gasMileage: 10.0)
var sportCar2 = SportCar (brand: "Ferrary", releaseYear: 1990, transmission: .manual, windowsState: .closed, mileage: 1000, roofState: .raised, gasMileage: 12.0)


car1.printCarInfo()
car2.printCarInfo()

print("Попробуем изменить состояние окон в автомобилях основного класса")

car1.carChange (action: .openWindows)
car2.carChange(action: .closeWindows)
print("Вот что у нас получилось")
car1.printCarInfo()
car2.printCarInfo()

print("Проверим, как работает слушатель пробега, унаследованный спортивным автомобилем от родительского класса")
sportCar1.printCarInfo()
print("Добавим автомобилю 2000 км пробега")
sportCar1.mileage = 2000
print("_______________")
print("Что изменилось?")
sportCar1.printCarInfo()

print("Проверим, работает ли наша кабриолетная крыша")
sportCar1.printCarInfo()
sportCar2.printCarInfo()
print("_______________")
sportCar1.carChange(action: .roofRaised)
sportCar1.carChange(action: .roofRaised)
print("_______________")
sportCar1.printCarInfo()
sportCar2.printCarInfo()

print("Поиграем с багажниками и их загрузкой у авто с прицепами")
trunkСar1.printCarInfo()
trunkCar2.printCarInfo()
print("_______________")
trunkСar1.carChange(action: .hookedTrunk)
trunkСar1.carChange(action: .loadTrunk(cargo: 250))
trunkCar2.carChange(action: .hookedTrunk)
trunkCar2.carChange(action: .loadTrunk(cargo: 500))
print("_______________")
print("Что изменилось?")
trunkСar1.printCarInfo()
trunkCar2.printCarInfo()
print("_______________")
Car.countInfo()
car2 = car1
Car.countInfo()
print("_______________")

trunkCar2 = trunkСar1
Car.countInfo()
trunkCar2.printCarInfo()
