//
//  DessertList.swift
//  FetchCodeChallenge
//
//  Created by Cristiano Salla Lunardi on 11/1/23.
//

import SwiftUI

struct DessertListView: View {
    @StateObject private var viewModel = DessertListViewModel()
    
    var body: some View {
        if viewModel.meals.isEmpty {
            ProgressView()
                .alert(Text(viewModel.alertText), isPresented: $viewModel.showAlert, actions: {
                    Button(viewModel.alertButton) {
                        viewModel.fetchList()
                    }
                })
        } else {
            NavigationView {
                ScrollView {
                    TitleView(title: viewModel.title)
                    
                    LazyVGrid(columns: [GridItem(), GridItem()]) {
                        ForEach(viewModel.meals, id: \.self) { meal in
                            NavigationLink(destination: DessertDetailsView(id: meal.idMeal)) {
                                ZStack(alignment: .bottom) {
                                    DessertListItemView(viewModel: DessertListItemViewModel(url: meal.strMealThumb, meal: meal.strMeal))
                                        .padding(4)
                                }
                            }
                        }
                    }
                    .padding([.leading, .trailing])
                }
            }
            .accentColor(.black)
        }
    }
}
