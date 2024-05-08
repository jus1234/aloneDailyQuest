//
//  Observable.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/8/24.
//

import Foundation

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        listener = closure
    }
}
