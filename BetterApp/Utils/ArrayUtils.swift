//
//  ArrayUtils.swift
//  BetterApp
//
//  Created by Vjeran Hanzek on 10/07/2019.
//

import Foundation

class ArrayUtils {
    
    public static func unique<S: Sequence, T: Hashable>(source: S) -> [T] where S.Iterator.Element == T {
        var buffer = [T]()
        var added = Set<T>()
        source.forEach { (elem) in
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
}
