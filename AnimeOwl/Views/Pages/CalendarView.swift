//
//  CalendarView.swift
//  AnimeOwl
//
//  Created by Uthman Mohamed on 2021-05-25.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var model: AnimeModel
    
    // Initialize at current date
    @State private var pickerSelectedDay = String(DateFormatter()
                                            .weekdaySymbols[Calendar.current.component(.weekday, from: Date()) - 1])
    
    @State private var tabSelection = 1
    
    private let gridItems = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    init() {
        UITabBar.appearance().barTintColor = UIColor.init(Color("button"))
        UITabBar.appearance().unselectedItemTintColor = .systemGray
    }
    
    var body: some View {
        ZStack {
            Color("button")
                .ignoresSafeArea()
            VStack {
                Picker(selection: $pickerSelectedDay, label:
                        Text("Day of Week: \(pickerSelectedDay)")
                        .font(Font.custom("Avenir Heavy", size: 16))
                        .foregroundColor(Color(.label))
                        .padding()
                        .background(Color(#colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)))
                        .cornerRadius(25.0)
                        .shadow(radius: 7)
                ) {
                    // Picker Items
                    ForEach(DaysOfWeek.allCases, id: \.self) { day in
                        Text(day.shortForm)
                            .tag(day.shortForm)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                
                TabView(selection: $tabSelection) {
                    ZStack {
                        BackgroundColour()
                        ScrollView(showsIndicators: false) {
                            if let animes = model.weeklyAnime?.getCurrentDay(forDay: pickerSelectedDay) {
                                LazyVGrid (columns: gridItems) {
                                    ForEach(animes) { anime in
                                        CalendarAnimeCard(anime: anime)
                                    }
                                }
                                .padding(.horizontal)
                            } else {
                                ProgressView()
                            }
                        }
                        
                    }
                    .onAppear {
                        model.getWeekdayAnime(forDay: pickerSelectedDay)
                    }
                    .onChange(of: pickerSelectedDay, perform: { _ in
                        model.getWeekdayAnime(forDay: pickerSelectedDay)
                    })
                    .tabItem {
                        VStack {
                            Image(systemName: "book")
                            
                            Text("Upcoming")
                        }
                    }
                    
                    
                    
                    ZStack {
                        BackgroundColour()
                        Text("Following")
                    }
                    .tabItem {
                        VStack {
                            Image(systemName: "star")
                            
                            Text("Following")
                        }
                    }
                }
                .accentColor(Color(#colorLiteral(red: 0.2656752765, green: 0.07812381536, blue: 0.06099386513, alpha: 1)))
            }
        }
        .onChange(of: pickerSelectedDay) { day in
            model.getWeekdayAnime(forDay: day)
        }
        
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView()
//    }
//}
