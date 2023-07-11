//
//  SearchedCitiesView.swift
//  WeatherAPI
//
//  Created by Çağla Karakuş on 23.05.2023.
//

import SwiftUI

struct SearchedCitiesView: View {
    @ObservedObject var viewModel: HomeViewModel = .init()
    
    var body: some View {
        let searchedCities = viewModel.getSearchedCityList()
        NavigationView{


            ZStack {
                VStack(alignment: .center, spacing: 0) {
                    ScrollView(.vertical, showsIndicators: false) {
                        Spacer(minLength: 5)
                        VStack {
                            ForEach(0..<searchedCities.count, id: \.self) { index in
                                Rectangle().foregroundColor(.gray.opacity(0.2))
                                    .frame(height: 150)
                                    .overlay(
                                        ZStack {
                                            CityItem(city: searchedCities[index])
                                        }
                                    ).cornerRadius(15).onTapGesture {
                                        //TODO tıklama action
                                        //print("Tıklanan Index: \(index)")
                                    }
                                
                            }
                        }.padding(.horizontal, 20)
                        Spacer(minLength: 100)
                    }
                }
            }

        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitleDisplayMode(.inline)
        .alert("Error Occured", isPresented: $viewModel.isAlertActive) {
            Button("OK", role: .cancel) { }
        }
    }
    
    private func CityItem(city: WeatherState) -> some View {
        HStack {
            HStack {
                VStack {
                    AsyncImage(url: city.icons[0]) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    } placeholder: {
                        Color.gray.opacity(0.1)
                    }
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("City: \(city.city)").font(.system(size: 18, weight: .bold)).foregroundColor(.black).fixedSize(horizontal: false, vertical: true)
                    Text("Temperature: \(city.temperature) °C").font(.system(size: 18, weight: .bold)).foregroundColor(.black)
                    Text("Description: \(city.desriptions[0])").font(.system(size: 18, weight: .bold)).foregroundColor(.black).fixedSize(horizontal: false, vertical: true)
                }
                Spacer()
            }.foregroundColor(.white).padding()
        }
    }
}

struct CityRow: View {
    var city: String

    var body: some View {
        Text("\(city)")
    }
}

