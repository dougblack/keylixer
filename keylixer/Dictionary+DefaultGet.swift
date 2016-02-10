//
//  Dictionary+DefaultGet.swift
//  keylixer
//
//  Created by Doug Black on 2/9/16.
//  Copyright © 2016 Doug Black. All rights reserved.
//

import Foundation

extension Dictionary {
    subscript(key: Key, or def: Value) -> Value {
        mutating get {
            return self[key] ?? {
                self[key] = def
                return def
                }()
        }
        set {
            self[key] = newValue
        }
    }
}