//
//  Drink.swift
//  NSCoffee
//
//  Created by Dani on 28/02/2025.
//

import Foundation

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
               imageName: "Espresso"),
        Coffee(name: "Macchiato",
               description: String(localized: "macchiatoDescription"),
               basePrice: 2.5,
               imageName: "Macchiato"),
        Coffee(name: "Cortado",
               description: String(localized: "cortadoDescription"),
               basePrice: 2.8,
               imageName: "Cortado"),
        Coffee(name: "Flat White",
               description: String(localized: "flatWhiteDescription"),
               basePrice: 3.7,
               imageName: "FlatWhite"),
        Coffee(name: "Latte",
               description: String(localized: "latteDescription"),
               basePrice: 3.8,
               imageName: "Latte"),
        Coffee(name: "Spanish Latte",
               description: String(localized: "spanishLatteDescription"),
               basePrice: 3.9,
               imageName: "SpanishLatte")
    ]
    
    let hotDrinks = [
        HotDrink(name: "Chai Latte",
                 description: String(localized: "chaiDescription"),
                 basePrice: 3.2,
                 imageName: "Chai"),
        HotDrink(name: "Hot Chocolate",
                 description: String(localized: "chocolateDescription"),
                 basePrice: 3.0,
                 imageName: "HotChoc")
    ]
    
    let coldDrinks = [
        ColdDrink(name: "Cold Brew",
                  description: String(localized: "coldBrewDescription"),
                  basePrice: 3.7,
                  imageName: "ColdBrew"),
        ColdDrink(name: "Frappé",
                  description: String(localized: "frappeDescription"),
                  basePrice: 3.8,
                  imageName: "Frappe"),
        ColdDrink(name: "Orxata",
                  description: String(localized: "orxataDescription"),
                  basePrice: 3.25,
                  imageName: "Orxata")
    ]
    
    func drinks(for drinkType: DrinkType) -> [Drink] {
        switch drinkType {
        case .coffee: coffees
        case .hotDrink: hotDrinks
        case .coldDrink: coldDrinks
        }
    }
}

protocol Drink {
    var name: String { get }
    var description: String { get }
    var basePrice: Double { get }
    var imageName: String? { get }
}

struct Coffee: Drink {
    let name: String
    let description: String
    let basePrice: Double
    var imageName: String? = nil
}

struct HotDrink: Drink {
    let name: String
    let description: String
    let basePrice: Double
    var imageName: String? = nil
}

struct ColdDrink: Drink {
    let name: String
    let description: String
    let basePrice: Double
    var imageName: String? = nil
}
