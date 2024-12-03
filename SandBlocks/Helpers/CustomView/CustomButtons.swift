import SwiftUI

struct SmallButton: View {
    var foregroundImage: String
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                Image(ImageName.smallButtonBackImage.rawValue)
                    .resizable()
                    .frame(width: 50, height: 50)
                
                Image(foregroundImage)
                    .resizable()
                    .frame(width: 25, height: 25)
            }
        }
    }
}

struct WideButton: View {
    var text: String
    var action: () -> Void
    var sizeWButton: CGFloat
    var sizeHButton: CGFloat
    var sizeText: CGFloat
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                Image(ImageName.buttonBackImage.rawValue)
                    .resizable()
                    .frame(width: sizeWButton, height: sizeHButton)
                
                Text(text)
                    .font(.custom("Yeast22-Regular", size: sizeText))
                    .foregroundColor(Color(#colorLiteral(red: 0/255, green: 178/255, blue: 70/255, alpha: 1)))
                    
            }
        }
    }
}

struct LevelButton: View {
    var text: String
    var image: String
    var action: () -> Void
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                Image(image)
                    .resizable()
                    .frame(width: 104, height: 104)
                
                Text(text)
                    .font(.custom("Yeast22-Regular", size: 52))
                    .foregroundColor(Color(#colorLiteral(red: 0/255, green: 178/255, blue: 70/255, alpha: 1)))
            }
        }
    }
}
