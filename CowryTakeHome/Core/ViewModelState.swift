//
//  ViewModelState.swift
//  CowryTakeHome
//
//  Created by Moses A. on 04/08/2025.
//

import Foundation

public enum ViewModelState<R> {
    case loading
    case result(payload: R)
    case failure(error : String)
}
