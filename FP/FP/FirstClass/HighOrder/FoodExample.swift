//
//  FoodExample.swift
//  FP
//
//  Created by ke Liu on 7/12/25.
//

func foodExample() {
    var foods: [String] = []
    var dishes: [String] = []
    
    //original code
    for food in foods {
        cook(food)
        eat(food)
    }
    
    for dish in dishes {
        wash(dish)
        dry(dish)
        putAway(dish)
    }
    
    //refactoring
    foods.forEach {
        cook($0)
        eat($0)
    }

    dishes.forEach {
        wash($0)
        dry($0)
        putAway($0)
    }
    
}




func cook(_ food: String) {}
func eat(_ food: String) {}
func wash(_ dish: String) {}
func dry(_ dish: String) {}
func putAway(_ dish: String) {}

