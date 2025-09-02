//
//  FreeTrialReminderViewModel.swift
//  SizeRecommend
//
//  Created by Ruby Vega on 9/2/25.
//

import Foundation
import SizeRecommendCore

final class SizeRecommendationViewModel: ObservableObject {
        
    @Published var size: SizeRecommendCore.Size? = nil
    @Published var error: String? = nil
        
    private let recomendationService = SizeRecommend()
    
    func setup() {
        print("Setting up `SizeRecommendationViewModel`...")
    }
    
    func onGetSize(height: Double, weight: Double) {
        let result = Result { try recomendationService.getSize(height: height, weight: weight) }
        
        switch result {
        case .success(let recommendedSize):
            self.size = recommendedSize
        case .failure(let error):
            self.error = error.localizedDescription
        }
    }
    
    func onDismiss() {
        size = nil
    }
    
    func onDismissError() {
        error = nil
    }
}
