//
//  SwiftUIView.swift
//  WeatherAPI
//
//  Created by Çağla Karakuş on 4/7/23.
//

import SwiftUI

struct WeatherDetailView: View {
    
    
    let weatherState : WeatherState
    
    var body: some View {
        
        VStack(spacing: 10){
            
            HStack{
                Spacer()
                Text("\(weatherState.temperature)")
                    .font(.system(size: 130, weight: .medium))
                    .overlay(alignment: .topTrailing){
                        Text("°C")
                            .font(.system(size: 40, weight: .light))
                            .offset(x: 40, y: -5) //spacerla yap
                    }
                Spacer()
            }
            Text(weatherState.city)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius:10)
                        .foregroundColor(Color("DarkGray")))
            HStack(spacing: 10){
                ForEach(weatherState.desriptions, id:\.self){ weatherDescription in

                    VStack(spacing: 2){
                        Text(weatherDescription)
                    }
                }
                ForEach(weatherState.icons, id:\.self){ imageURL in
                        AsyncImage(url: imageURL, content: { image in
                            image
                                .resizable()
                                .scaledToFit()
                        }, placeholder: {
                            ProgressView()
                        })
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("DarkGray"))
            )
             
            
        }
        .frame(maxHeight: .infinity)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetailView(weatherState: WeatherState(temperature: 17, city: "Besiktas", desriptions: ["hafif ruzgarlı"], icons: [URL(string: "https://assets.weatherstack.com/images/wsymbols01_png_64/wsymbol_0001_sunny.png")!]))
    }
}
