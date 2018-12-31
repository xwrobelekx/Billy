//
//  BilllFrequencyEnum.swift
//  Billy
//
//  Created by Kamil Wrobel on 12/5/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation


enum BillFrequency: String, CaseIterable {
    case none = "None"
    case weekly = "Weekly"
    case biweekly = "Biweekly"
    case monthly = "Monthly"
    case quarterly = "Quarterly"
    case semiAnual = "Semi Anual"
    case anual = "Anual"
}
