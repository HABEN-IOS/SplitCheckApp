//
//  ContentView.swift
//  SplitCheckApp
//
//  Created by Haben Gebremeskel on 1/22/25.
//


import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    
    var totalPerPerson: Double {
        checkTotal / Double(numberOfPeople)
    }
    
    var checkTotal: Double {
        let tip = checkAmount / 100 * Double(tipPercentage)
        let total = checkAmount + tip
        return total
    }
    
    let local = Locale.current.currency?.identifier ?? "GBP"
    

    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Check Amount", value: $checkAmount, format: .currency(code: local))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip? (%20)") {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Check total") {
                    Text(checkTotal, format: .currency(code: local))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: local))
                }
            }
            .navigationTitle("SplitCheck")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}




