//
//  ratingView.swift
//  Bookworm
//
//  Created by Nana Bonsu on 4/24/23.
//

import SwiftUI

struct RatingView: View {
    
    //making a custom rating ,
    @Binding var rating: Int
    
    var label = ""
    var maxRating = 5
    
    var offImage:Image? //maybe the image when its not clicked
    
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            //maxRating + 1 due to the last element not being included
            ForEach(1..<maxRating + 1,id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > rating ? offColor : onColor)
                    .onTapGesture {
                        rating = number //so basically when user taps a star,the rating will be set to what star he choses, increases as well
                    }
            }
        }
    }
    
    //now image login function
    
    func image(for number:Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct ratingView_Previews: PreviewProvider {
    static var previews: some View {
        RatingView(rating: .constant(4))
    }
}
