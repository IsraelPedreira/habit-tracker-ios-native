//
//  Habit.swift
//  HabitApp
//
//  Created by Israel Almeida on 31/10/26.
//

import Foundation
import SwiftData

@Model
class Habit{
    var name: String
    var desc: String
    var timesCompleted: Int
    
    init(name: String, desc: String = "", timesCompleted: Int = 0){
        self.name = name
        self.desc = desc
        self.timesCompleted = timesCompleted
    }
}
