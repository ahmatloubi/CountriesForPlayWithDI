//
//  CreateCountryView.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import SwiftUI

struct CreateCountryView: View {
    @ObservedObject var viewModel: CreateCountryViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30){
                TextField("Country", text: $viewModel.name)
                TextField("Capital", text: $viewModel.capital)
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.onTapCancel()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        viewModel.onTapDoneButton()
                    }
                }
            }
        }
    }
}
