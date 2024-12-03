import SwiftUI

struct ExitView: View {
    @StateObject var exitModel =  ExitViewModel()

    var body: some View {
        ZStack {
            Image(ImageName.shopBackground.rawValue)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    Spacer()
                    Text("EXIT")
                        .Yeast(size: 96)
          
                    Spacer()
                    ZStack {
                        
                        Image(ImageName.shopItemBackground.rawValue)
                            .resizable()
                            .frame(width: 354, height: 356)
                        
                        VStack(spacing: 15) {
                            Text("ARE YOU SURE YOU WANT TO EXIT THE GAME?")
                                .Yeast(size: 25)
                                .frame(width: 205)
                                .multilineTextAlignment(.center)
                                .lineLimit(5)
                            
                            Text("ALL YOUR PROGRESS WILL BE LOST.")
                                .Yeast(size: 25, color: .white)
                                .frame(width: 205)
                                .multilineTextAlignment(.center)
                                .lineLimit(5)
                        }
                        
                        ZStack {
                            Image(ImageName.currenTimeBackgroundImage.rawValue)
                                .resizable()
                                .frame(width: 162, height: 78)
                            
                            HStack {
                                Image(ImageName.coinCount.rawValue)
                                    .resizable()
                                .frame(width: 24, height: 24)
                                
                                Text("COIN: 1000")
                                    .Yeast(size: 20)
                            }
                        }
                        .offset(y: -190)
                        
                        HStack(spacing: 50) {
                            WideButton(text: "NO!",
                                       action: exitModel.goToMenu,
                                       sizeWButton: 133,
                                       sizeHButton: 78,
                                       sizeText: 25)

                            WideButton(text: "YES!",
                                       action: exitModel.goToMenu,
                                       sizeWButton: 133,
                                       sizeHButton: 78,
                                       sizeText: 25)
                        }
                        .offset(y: 160)
                    }
                    Spacer()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ExitView()
}

