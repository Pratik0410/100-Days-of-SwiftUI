//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Prathamesh Sonawane on 08/07/24.
//

import Foundation

extension EditView {
    @Observable
    class ViewModel {
        enum LoadingStates {
            case loading, loaded, failed
        }
        
        var location: Location?
        var name: String
        var description: String
        
        var loadingState = LoadingStates.loading
        var pages = [Page]()
        
        init(location: Location) {
            self.location = location
            self.name = location.name
            self.description = location.description
            self.loadingState = loadingState
            self.pages = pages
        }
    }
}
