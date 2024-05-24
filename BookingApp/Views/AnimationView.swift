//
//  AnimationView.swift
//  BookingApp
//
//  Created by Joakim.Bjärkstedt on 2024-05-22.
//

import SwiftUI
import Lottie

struct AnimationView: UIViewRepresentable {
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    var fileName: String
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame:.zero)
        
        let animationView = Lottie.LottieAnimationView(name:fileName)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
}
  


/*#Preview {
 AnimationView()
 }
 */
