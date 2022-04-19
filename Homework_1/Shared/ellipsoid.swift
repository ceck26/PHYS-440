//
//  ellipsoid.swift
//  Homework 1
//
//  Created by Christopher Eckenrode on 4/19/22.
//

import SwiftUI

class ellipsoid: NSObject, ObservableObject {
    
    var xAxisLength = 0.0
    var yAxisLength = 0.0
    var zAxisLength = 0.0
    var centerOfAnEllipse = (x:0.0, y:0.0, z:0.0)
    
    @Published var e_volume = 0.0
    @Published var bb_volume = 0.0
    @Published var e_surface_area = 0.0
    @Published var bb_surface_area = 0.0
    @Published var e_v_Text = ""
    @Published var bb_v_Text = ""
    @Published var e_s_Text = ""
    @Published var bb_s_Text = ""
    @Published var enableButton = true
    
    @MainActor func initWithAxis(xAxis: Double, yAxis: Double, zAxis: Double) async -> Bool {
        
        xAxisLength = xAxis
        yAxisLength = yAxis
        zAxisLength = zAxis
        
        let _ = await withTaskGroup(of:  Void.self) { taskGroup in
            taskGroup.addTask { let _ = await self.calculate_e_volume(xAxis: self.xAxisLength, yAxis: self.yAxisLength, zAxis: self.zAxisLength)}
            taskGroup.addTask { let _ = await self.calculate_bb_volume(xAxis: self.xAxisLength, yAxis: self.yAxisLength, zAxis: self.zAxisLength)}
            taskGroup.addTask { let _ = await self.calculate_e_surface_area(xAxis: self.xAxisLength, yAxis: self.yAxisLength, zAxis: self.zAxisLength)}
            taskGroup.addTask { let _ = await self.calculate_bb_surface_area(xAxis: self.xAxisLength, yAxis: self.yAxisLength, zAxis: self.zAxisLength)}
        }
        
        await setButtonEnable(state: true)
        
        return true
        
    }
    
    @MainActor func calculate_e_volume(xAxis: Double, yAxis: Double, zAxis: Double) async -> Double {
        
        //Area = pi * majorAxis * minorAxis
        
        let calculate_e_volume = (4 / 3) * Double.pi * xAxis * yAxis * zAxis
        let newVolumeText = String(format: "%7.5f", calculate_e_volume)
        
        self.e_v_Text = newVolumeText
        self.e_volume = calculate_e_volume
        
        return calculate_e_volume
        
    }
    
    @MainActor func calculate_bb_volume(xAxis: Double, yAxis: Double, zAxis: Double) async -> Double {
        
        //Area = pi * majorAxis * minorAxis
        
        let calculate_bb_volume = 8 * xAxis * yAxis * zAxis
        let newVolumeText = String(format: "%7.5f", calculate_bb_volume)
        
        self.bb_v_Text = newVolumeText
        self.bb_volume = calculate_bb_volume
        
        return calculate_bb_volume
        
    }
    
    @MainActor func calculate_e_surface_area(xAxis: Double, yAxis: Double, zAxis: Double) async -> Double {
        
        //Area = pi * majorAxis * minorAxis
        
        let a = pow((xAxis * yAxis),1.6)
        let b = pow((xAxis * zAxis),1.6)
        let c = pow((yAxis * zAxis),1.6)
        let d = a + b + c
        let e = d / 3
        let f = pow(e,(1/1.6))
        let g = f * Double.pi * 4
        let calculate_e_surface_area = g
        let newsurface_areaText = String(format: "%7.5f", calculate_e_surface_area)
        
        self.e_v_Text = newsurface_areaText
        self.e_surface_area = calculate_e_surface_area
        
        return calculate_e_surface_area
        
    }
    
    @MainActor func calculate_bb_surface_area(xAxis: Double, yAxis: Double, zAxis: Double) async -> Double {
        
        //Area = pi * majorAxis * minorAxis
        
        let calculate_bb_surface_area = (2 * (xAxis * yAxis) + 2 * (xAxis * zAxis) + 2 * (yAxis * zAxis))
        let newsurface_areaText = String(format: "%7.5f", calculate_bb_surface_area)
        
        self.bb_v_Text = newsurface_areaText
        self.bb_surface_area = calculate_bb_surface_area
        
        return calculate_bb_surface_area
        
    }
    
    @MainActor func setButtonEnable(state: Bool){
        
        
        if state {
            
            Task.init {
                await MainActor.run {
                    
                    
                    self.enableButton = true
                }
            }
            
            
                
        }
        else{
            
            Task.init {
                await MainActor.run {
                    
                    
                    self.enableButton = false
                }
            }
                
        }
        
    }
    
}
