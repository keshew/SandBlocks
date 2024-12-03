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
            }
        }
    }
}

struct LevelButton: View {
    var text: String
    var action: () -> Void
//    var sizeWButton: CGFloat
//    var sizeHButton: CGFloat
//    var sizeText: CGFloat
    var body: some View {
        Button(action: {
            action()
        }) {
            ZStack {
                Image(ImageName.smallButtonForLevelsImage.rawValue)
                    .resizable()
                    .frame(width: 104, height: 104)
                
                Text(text)
                    .font(.custom("", size: 52))
            }
        }
    }
}
