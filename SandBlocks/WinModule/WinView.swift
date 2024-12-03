import SwiftUI

struct WinView: View {
    @StateObject var winModel =  WinViewModel()

    var body: some View {
        ZStack {
            Image(ImageName.shopBackground.rawValue)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    Spacer()
                    Text("VICTORY")
                        .Yeast(size: 96)
          
                    Spacer()
                    ZStack {
                        
                        Image(ImageName.shopItemBackground.rawValue)
                            .resizable()
                            .frame(width: 354, height: 356)
                        
                        VStack(spacing: 15) {
                            Text("YOU CRUSHED THE QUEST")
                                .Yeast(size: 25)
                                .frame(width: 215)
                                .multilineTextAlignment(.center)
                                .lineLimit(5)
                            
                            Text("AND BEAT THE CLOCK")
                                .Yeast(size: 25, color: .white)
                                .frame(width: 225)
                                .multilineTextAlignment(.center)
                                .lineLimit(5)
                            
                            VStack(spacing: 0) {
                                Text("THIS IS YOUR")
                                    .Yeast(size: 20)
                                    .frame(width: 215)
                                    .multilineTextAlignment(.center)
                                .lineLimit(5)
                                
                                HStack(spacing: -40) {
                                    Text("REWARD: 30")
                                        .Yeast(size: 20, color: .white)
                                        .frame(width: 215)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(5)
                                    
                                    Image(ImageName.coinCount.rawValue)
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                }
                                .offset(x: -5)
                            }
                            
                           
                        }
                        
                        ZStack {
                            Image(ImageName.currenTimeBackgroundImage.rawValue)
                                .resizable()
                                .frame(width: 162, height: 78)
                            
                            HStack {
                                Image(ImageName.coinCount.rawValue)
                                    .resizable()
                                .frame(width: 24, height: 24)
                                
                                Text("COIN: \(winModel.coin ?? 0)")
                                    .Yeast(size: 20)
                            }
                        }
                        .offset(y: -190)
                        
                        HStack(spacing: 50) {
                            WideButton(text: "MENU",
                                       action: winModel.goToMenu,
                                       sizeWButton: 133,
                                       sizeHButton: 78,
                                       sizeText: 25)

                            WideButton(text: "NEXT",
                                       action: winModel.goToMenu,
                                       sizeWButton: 133,
                                       sizeHButton: 78,
                                       sizeText: 25)
                        }
                        .offset(y: 160)
                    }
                    Spacer()
                }
            }
            .navigationDestination(isPresented: $winModel.isMenuAvailible) {
                MenuView()
            }
            
            .navigationDestination(isPresented: $winModel.isLevelAvailible) {
                MenuView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WinView()
}

