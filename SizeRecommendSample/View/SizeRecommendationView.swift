//
//  SizeRecommendationView.swift
//  SizeRecommend
//
//  Created by Ruby Vega on 9/2/25.
//

import SwiftUI
import SizeRecommendCore

struct SizeRecommendationView: View {

    @ObservedObject var viewModel: SizeRecommendationViewModel
    @State private var height: Double = 0.0
    @State private var weight: Double = 0.0
    @State private var isShowRecommendation: Bool = false
    @State private var isShowError: Bool = false

    init(viewModel: SizeRecommendationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Find Your Perfect Fit")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    VStack(spacing: 16) {
                        HStack(spacing: 5) {
                            Text("Height:")
                                .fontWeight(.medium)
                                .padding()
                            
                            TextField("Enter height (cm)", value: $height, format: .number)
                                .keyboardType(.decimalPad)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                            
                            Text("cm")
                                .fontWeight(.medium)
                                .padding()
                        }
                        
                        HStack(spacing: 5) {
                            Text("Weight:")
                                .fontWeight(.medium)
                                .padding()
                            
                            TextField("Enter weight (kg)", value: $weight, format: .number)
                                .keyboardType(.decimalPad)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(10)
                            
                            Text("kg")
                                .fontWeight(.medium)
                                .padding()
                        }
                    }
                    
                    Button(action: {
                        viewModel.onGetSize(height: height, weight: weight)
                    }) {
                        Text("Get Size Recommendation")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .shadow(radius: 2)
                    }
                }
                .onChange(of: viewModel.size) { oldValue, newValue in
                    guard newValue != nil else { return }
                    
                    isShowRecommendation = true
                }
                .onChange(of: viewModel.error) { oldValue, newValue in
                    guard newValue != nil else { return }
                    
                    isShowError = true
                }
                .padding()
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 20)
                
                Spacer()
            }
            .alert("Your Recommended Size: \(viewModel.size?.name ?? "")", isPresented: $isShowRecommendation, actions: {
                Button("OK") {
                    isShowRecommendation = false
                    viewModel.onDismiss()
                }
            }, message: {
                Text("Based on your info, size \(viewModel.size?.name ?? "") is recommended.")
            })
            .alert("Error", isPresented: $isShowError, actions: {
                Button("OK") {
                    isShowError = false
                    viewModel.onDismissError()
                }
            }, message: {
                Text(viewModel.error ?? "")
            })
        }
    }
    
    #Preview {
        SizeRecommendationView(viewModel: SizeRecommendationViewModel())
    }
}
