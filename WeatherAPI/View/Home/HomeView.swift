//
//  HomeView.swift
//  WeatherAPI
//
//  Created by Çağla Karakuş on 10.03.2023.
//


import SwiftUI

struct HomeView: View {
    
    //viewbuilder bak datayı search history ile tutmak lazım navigation link veya buton ile göndereceğin sayfadaki yeni viewde. Sonra orda konumlara tıklayıp ayrıntılı bakılabilecek.
    
    //af dokumantasyonu, observed object state object extensionların doğru kullanımı viewbuilder kullanımı ,  navigationview kullanımı iyice bak  /combine framework şimdi bakma
    // MARK: Properties
    @ObservedObject var viewModel: HomeViewModel = .init()
    // MARK: Body
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationView{


            ZStack{
                LinearGradient(colors: [.blue,.white], startPoint:.topLeading , endPoint:.bottomTrailing).edgesIgnoringSafeArea(.all)

                VStack(spacing: 0){

                    searchBarView
                    
                    if viewModel.weatherState != nil{

                        WeatherDetailView(weatherState:viewModel.weatherState)
                    }



                }
                .navigationTitle("Weather App")
                .toolbar(){
                    NavigationLink(destination: SearchedCitiesView()){
                        Text("Searched Cities").foregroundColor(.black)
                    }
                }



            }

        }
        .navigationViewStyle(StackNavigationViewStyle())
        .alert("Error Occured", isPresented: $viewModel.isAlertActive) {
            Button("OK", role: .cancel) { }
        }
        
    }
    
    
    
    var searchBarView: some View {
        HStack{
            // MARK: SEARCH BAR
            TextField("Search City", text: $viewModel.searchString)
            Spacer()
            Button {
                viewModel.fetchWeatherData(for: viewModel.searchString) { response in
                    switch response{
                    case .success(_):
                        break
                    case .failure(_):
                        DispatchQueue.main.async {
                            viewModel.isAlertActive.toggle()
                        }
                    }
                }
                
            } label: {
                Image("search")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                    .padding(.trailing, 4)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color("DarkGray")))
        .padding(10)
    }
    
}



// MARK: - Preview Provider
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
