//
//  ContentView.swift
//  Drawing
//
//  Created by Andrei Korikov on 14.08.2021.
//

import SwiftUI

struct ArrowUp: Shape {
  func path(in rect: CGRect) -> Path {
    var path = Path()
    
    path.move(to: CGPoint(x: rect.midX, y: rect.minY))
    path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
    path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
    path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
    path.addRect(CGRect(x: rect.midX / 2, y: rect.midY, width: rect.width / 2, height: rect.height / 2))
    
    return path
  }
}

struct ColorCyclingRectangle: View {
  var amount = 0.0
  var steps = 100
  var offset = 0.0
  
  var body: some View {
    ZStack {
      ForEach(0..<steps) { value in
        Rectangle()
          .inset(by: CGFloat(Double(value) + offset))
          .strokeBorder(self.color(for: value, brightness: 1), lineWidth: 2)
      }
    }
  }
  
  func color(for value: Int, brightness: Double) -> Color {
    var targetHue = Double(value) / Double(self.steps) + self.amount
    
    if targetHue > 1 {
      targetHue -= 1
    }
    
    return Color(hue: targetHue, saturation: 1, brightness: brightness)
  }
}

struct ContentView: View {
  @State private var arrowThick: CGFloat = 1
  @State private var rectOffset = 0.0
  
  var body: some View {
    VStack {
      ArrowUp()
        .stroke(style: StrokeStyle(lineWidth: arrowThick, lineCap: .round, lineJoin: .round))
        .frame(width: 300, height: 300)
        .onTapGesture {
          withAnimation {
            if arrowThick < 50 {
              arrowThick += 10
            } else {
              arrowThick = 1
            }
          }
        }
      
      HStack {
        Text("Line width:")
          .font(.title2)
          .foregroundColor(.green)
        
        Slider(value: $arrowThick, in: 1...50)
          .accentColor(.green)
      }
      .padding()
      
      ColorCyclingRectangle(offset: rectOffset)
      
      Slider(value: $rectOffset, in: 0.0...50.0)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
