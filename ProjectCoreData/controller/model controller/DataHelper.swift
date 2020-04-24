//
//  DataHelper.swift
//  ProjectCoreData
//
//  Created by Pete Parks on 4/22/20.
//  Copyright © 2020 Pete Parks. All rights reserved.
//

import UIKit

extension Date {
    
    func stringValue() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium

        return formatter.string(from: self)
    }
    
}

