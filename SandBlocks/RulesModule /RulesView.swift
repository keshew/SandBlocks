import SwiftUI

struct RulesView: View {
    @StateObject var rulesModel =  RulesViewModel()
    var body: some View {
        ZStack {
            Image(ImageName.shopBackground.rawValue)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack {
                        SmallButton(foregroundImage: ImageName.backArrowImage.rawValue,
                                    action: rulesModel.goToMenu)
                        Spacer()
                    }
                    .padding()
                    
                    Text("RULES")
                        .Yeast(size: 104)
                    
                    ZStack {
                        Image(ImageName.shopItemBackground.rawValue)
                            .resizable()
                            .frame(width: 354, height: 356)
                        
                        VStack(spacing: 15) {
                            Text("Match blocks of the same color. Place them next to each other to score points.")
                                .Yeast(size: 20)
                                .frame(width: 215)
                                .multilineTextAlignment(.center)
                                .lineLimit(5)
                            
                            Text("The more blocks you match, the higher your score! Game over when no more moves can be made.")
                                .Yeast(size: 20, color: .white)
                                .frame(width: 215)
                                .multilineTextAlignment(.center)
                                .lineLimit(5)
                        }
                    }
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $rulesModel.isMenuAvailible) {
                GameView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RulesView()
}

