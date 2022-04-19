//
//  ContentView.swift
//  Shared
//
//  Created by Christopher Eckenrode on 04/19/22.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var circleModel = ellipsoid()
    @State var radiusString = "1.0"
    
    var body: some View {
        
        VStack{
            Text("Radius")
                .padding(.top)
                .padding(.bottom, 0)
            TextField("Enter Radius", text: $radiusString, onCommit: {Task.init {await self.calculateCircle()}})
                .padding(.horizontal)
                .frame(width: 100)
                .padding(.top, 0)
                .padding(.bottom, 30)
            HStack {
        VStack{
            Text("Sphere Volume")
                .padding(.bottom, 0)
            Text("\(circleModel.e_volume, specifier: "%.2f")")
                .padding(.horizontal)
                .frame(width: 100)
                .padding(.top, 0)
                .padding(.bottom,30)
                
            }
            }
            HStack{
                VStack{
                    Text("Sphere Surface Area")
                        .padding(.bottom, 0)
                    Text("\(circleModel.e_surface_area, specifier: "%.2f")")
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                        
                    }

                
                
            }
            
            HStack {
        VStack{
            Text("Box Volume")
                .padding(.bottom, 0)
            Text("\(circleModel.bb_volume, specifier: "%.2f")")
                .padding(.horizontal)
                .frame(width: 100)
                .padding(.top, 0)
                .padding(.bottom,30)
                
            }
            }
            HStack{
                VStack{
                    Text("Bounding Box Surface Area")
                        .padding(.bottom, 0)
                    Text("\(circleModel.bb_surface_area, specifier: "%.2f")")
                        .padding(.horizontal)
                        .frame(width: 100)
                        .padding(.top, 0)
                        .padding(.bottom,30)
                        
                    }

                
                
            }
            
            Button("Calculate", action: {Task.init { await self.calculateCircle()}})
                .padding(.bottom)
                .padding()
                .disabled(circleModel.enableButton == false)
            
            
        }
        
    }
    
    func calculateCircle() async {
        
        circleModel.setButtonEnable(state: false)
        
        if Double(radiusString) != nil {
        
        let _ : Bool = await circleModel.initWithAxis(xAxis: Double(radiusString)!, yAxis: Double(radiusString)!, zAxis: Double(radiusString)!)
        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

