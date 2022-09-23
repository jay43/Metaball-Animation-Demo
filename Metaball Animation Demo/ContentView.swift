//
//  ContentView.swift
//  Metaball Animation Demo
//
//  Created by Jay Khunt on 22/09/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WaveView()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
