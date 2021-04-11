//
//  Array+Identifiable.swift
//  Memorize
//
//  Created by William Ye on 2021-04-08.
//

import Foundation

extension Array where Element: Identifiable {
    func index(of target: Element) -> Int?{
        for i in 0..<self.count{
            if self[i].id == target.id{
                return i
            }
        }
        return nil 
    }
}
