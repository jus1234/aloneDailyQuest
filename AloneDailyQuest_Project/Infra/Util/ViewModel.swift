//
//  ViewModel.swift
//  AloneDailyQuest_Project
//
//  Created by Wooseok on 5/8/24.
//

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) async -> Output
}
