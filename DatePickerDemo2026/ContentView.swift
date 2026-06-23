//
//  ContentView.swift
//  DatePickerDemo2026
//
//  Created by Douglas Jasper on 2026-06-23.
//

import SwiftUI

struct ContentView: View {
    // --- DatePicker state ---
    @State private var selectedDate = Date()
    
    // --- Season Picker state ---
    @State private var selectedSeason = "Spring"
    private let seasons = ["Spring", "Summer", "Autumn", "Winter"]
    
    // --- Slider state ---
    @State private var age: Double = 25 // Default starting age
    
    // Date formatter
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    
                    // --- Date Picker Card ---
                    CardView(title: "Select a Date") {
                        DatePicker("Pick a date:", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                            .datePickerStyle(.graphical)
                            .padding(.top, 5)
                        
                        Text("Selected Date:")
                            .font(.headline)
                        Text(formattedDate)
                            .foregroundColor(.blue)
                    }
                    
                    // --- Season Picker Card ---
                    CardView(title: "Favorite Season") {
                        Picker("Favorite Season", selection: $selectedSeason) {
                            ForEach(seasons, id: \.self) { season in
                                Text(season)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(height: 160)
                        .clipped()
                        
                        Text("You selected:")
                            .font(.headline)
                        Text(selectedSeason)
                            .foregroundColor(.green)
                    }
                    
                    // --- Age Slider Card ---
                    CardView(title: "Select Your Age") {
                        Slider(value: $age, in: 1...100, step: 1)
                            .tint(.purple)
                            .padding(.horizontal)
                        
                        Text("Age: \(Int(age)) years old")
                            .font(.headline)
                            .foregroundColor(.purple)
                    }
                }
                .padding()
            }
            .navigationTitle("Profile Preferences")
            .background(Color(.systemGroupedBackground))
        }
    }
}

// MARK: - Card View Component
struct CardView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text(title)
                .font(.title3)
                .bold()
                .padding(.bottom, 5)
            
            content
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.15), radius: 8, x: 0, y: 3)
    }
}
#Preview {
    ContentView()
}
