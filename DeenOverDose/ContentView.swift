//
//  ContentView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-11-15.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                NavigationLink(destination: Text("Detailed View")) {
                    Text("Story")
                }
                .padding()
                NavigationLink(destination: Text("Detailed View")) {
                    Text("Arena")
                }
                .padding()
                NavigationLink(destination: TrialsView()) {
                    Text("Trials")
                }
                .padding()
            }
            .frame(width: 400, height: 400)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
