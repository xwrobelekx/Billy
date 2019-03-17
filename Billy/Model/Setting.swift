//
//  Setting.swift
//  Billy
//
//  Created by Kamil Wrobel on 3/12/19.
//  Copyright © 2019 Kamil Wrobel. All rights reserved.
//

import Foundation


class Setting: Codable, Equatable {

    
    var hour: Int
    var minute: Int
    var dayDelay: Int
    
    init(hour: Int, minute: Int , dayDelay: Int){
        self.hour = hour
        self.minute = minute
        self.dayDelay = dayDelay
    }
    
    static func == (lhs: Setting, rhs: Setting) -> Bool {
        return lhs.hour == rhs.hour && lhs.minute == rhs.minute && lhs.dayDelay == rhs.dayDelay
    }
    
}
