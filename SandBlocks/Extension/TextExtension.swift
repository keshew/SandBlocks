import SwiftUI

extension Text {
    func Yeast(size: CGFloat, color: Color = Color(#colorLiteral(red: 0/255, green: 178/255, blue: 70/255, alpha: 1))) -> some View {
        self.font(.custom("Yeast22-Regular", size: size))
            .bold()
            .foregroundColor(color)
    }
}
