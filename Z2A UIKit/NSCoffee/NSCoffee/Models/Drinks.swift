//
//  Drink.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import Foundation

enum MilkOptions: String, CaseIterable {
    case dairy = "Dairy"
    case oat = "Oat"
    case soy = "Soy"
    case coconut = "Coconut"
    case almond = "Almond"
}

enum DrinkType: String.LocalizationValue, CaseIterable {
    case coffee
    case hotDrink
    case coldDrink

    func localizedName() -> String {
        return String(localized: self.rawValue)
    }
}

struct Drinks {
    let coffees = [
        Coffee(name: "Espresso",
               description: String(localized: "espressoDescription"),
               basePrice: 2.0,
               imageName: "Espresso",
               shotPrice: 0.4),
        Coffee(name: "Macchiato",
               description: String(localized: "macchiatoDescription"),
               basePrice: 2.5,
               imageName: "Macchiato",
               shotPrice: 0.5),
        Coffee(name: "Cortado",
               description: String(localized: "cortadoDescription"),
               basePrice: 2.8,
               imageName: "Cortado",
               shotPrice: 0.6),
        Coffee(name: "Flat White",
               description: String(localized: "flatWhiteDescription"),
               basePrice: 3.7,
               imageName: "FlatWhite",
               shotPrice: 0.75),
        Coffee(name: "Latte",
               description: String(localized: "latteDescription"),
               basePrice: 3.8,
               imageName: "Latte",
               shotPrice: 0.75),
        Coffee(name: "Spanish Latte",
               description: String(localized: "spanishLatteDescription"),
               basePrice: 3.9,
               imageName: "SpanishLatte",
               shotPrice: 0.8)
    ]

    let hotDrinks = [
        HotDrink(name: "Chai Latte",
                 description: String(localized: "chaiDescription"),
                 basePrice: 3.2,
                 imageName: "Chai",
                 shotPrice: 0.65),
        HotDrink(name: "Hot Chocolate",
                 description: String(localized: "chocolateDescription"),
                 basePrice: 3.0,
                 imageName: "HotChoc",
                 shotPrice: 0.6)
    ]

    let coldDrinks = [
        ColdDrink(name: "Cold Brew",
                  description: String(localized: "coldBrewDescription"),
                  basePrice: 3.7,
                  imageName: "ColdBrew",
                  shotPrice: 0.75),
        ColdDrink(name: "Frappé",
                  description: String(localized: "frappeDescription"),
                  basePrice: 3.8,
                  imageName: "Frappe",
                  shotPrice: 0.75),
        ColdDrink(name: "Orxata",
                  description: String(localized: "orxataDescription"),
                  basePrice: 3.25,
                  imageName: "Orxata",
                  shotPrice: 0.65)
    ]
    
    
    func drinks(for drinkType: DrinkType) -> [any Drink] {
        switch drinkType {
        case .coffee: coffees
        case .hotDrink: hotDrinks
        case .coldDrink: coldDrinks
        }
    }

}

protocol Drink: Identifiable {
    var id: UUID { get }
    var name: String { get }
    var description: String { get }
    var basePrice: Double { get }
    var imageName: String? { get }
    var shotPrice: Double { get }
}

struct Coffee: Drink {
    let id = UUID()
    let name: String
    let description: String
    let basePrice: Double
    var imageName: String? = nil
    let shotPrice: Double
}

struct HotDrink: Drink {
    let id = UUID()
    let name: String
    let description: String
    let basePrice: Double
    var imageName: String? = nil
    let shotPrice: Double
}

struct ColdDrink: Drink {
    let id = UUID()
    let name: String
    let description: String
    let basePrice: Double
    var imageName: String? = nil
    let shotPrice: Double
}
