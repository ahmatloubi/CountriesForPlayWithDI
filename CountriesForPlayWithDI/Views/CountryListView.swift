//
//  MainView.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import SwiftUI

struct CountryListView: View {
    @ObservedObject var viewModel: CountriesListViewModel
    @EnvironmentObject var container: Container
    
    init(viewModel: CountriesListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        containerView()
            .sheet(isPresented: $viewModel.shouldPresentSelectCountryView, content: {
                CreateCountryView(viewModel: container.countriesFlowContainer.createCountryViewModel())
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        viewModel.onTapCreateCountryButton()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
    }
    
    @ViewBuilder
    func containerView() -> some View {
        switch viewModel.viewState {
        case .loading:
            ProgressView()
                .onAppear {
                    viewModel.loadCountries()
                }
        case .list(let countries):
            List(countries) { country in
                Text(country.name)
            }
        case .emptyList:
            VStack {
                Text(viewModel.emptyMessage)
                Button("Add Country") {
                }
            }
        }
    }
}

struct CountryListview_Previews: PreviewProvider {
    static let container = Container()
    static let viewModel = container.countriesFlowContainer.countryListViewModel()
    
    static var previews: some View {
        CountryListView(viewModel: viewModel)
    }
    
}
