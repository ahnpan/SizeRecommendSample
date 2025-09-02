//
//  SizeRecommendSampleApp.swift
//  SizeRecommendSample
//
//  Created by Ruby Vega on 9/3/25.
//

import SwiftUI

@main
struct SizeRecommendSampleApp: App {
    var body: some Scene {
        WindowGroup {
            SizeRecommendationView(viewModel: SizeRecommendationViewModel())
        }
    }
}
