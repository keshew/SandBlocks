import SwiftUI

struct MenuView: View {
    @StateObject var menuModel =  MenuViewModel()
    @State private var showShop = false
    @State private var showDaily = false
    
    func goToShop() {
        showShop.toggle()
    }
    
    func goToDaily() {
        showDaily.toggle()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image(ImageName.menuBackImage.rawValue)
                    .resizable()
                    .ignoresSafeArea()
                
                Image(ImageName.womanImage.rawValue)
                    .resizable()
                    .frame(minWidth: 250, maxWidth: 370, minHeight: 400, maxHeight: 600)
                    .offset(x: 10, y: 120)
                
                if showShop {
                    ShopView(showShop: $showShop)
                        .transition(.opacity)
                        .zIndex(1)
                }
                
                if showDaily {
                    DailyRewardView(showDaily: $showDaily)
                        .transition(.opacity)
                        .zIndex(1)
                }
                
                VStack {
                    VStack {
                        HStack {
                            SmallButton(foregroundImage: ImageName.musicImage.rawValue,
                                        action: menuModel.enableMusic)
                            Spacer()
                            SmallButton(foregroundImage: ImageName.soundImage.rawValue,
                                        action: menuModel.enableSound)
                        }
                        .padding()
                        
                        Text("GAME")
                            .Yeast(size: 64, color: .white)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .frame(width: 200)
                        
                        Text("NAME")
                            .Yeast(size: 64)
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                    }
                    Spacer()
                    VStack {
                        WideButton(text: "PLAY",
                                   action: menuModel.goToGame,
                                   sizeWButton: 170,
                                   sizeHButton: 95,
                                   sizeText: 32)
                        
                        HStack {
                            WideButton(text: "LEVELS",
                                       action: menuModel.goToLevel,
                                       sizeWButton: 140,
                                       sizeHButton: 79,
                                       sizeText: 24)
                            
                            WideButton(text: "SHOP",
                                       action: goToShop,
                                       sizeWButton: 140,
                                       sizeHButton: 79,
                                       sizeText: 24)
                        }
                        
                        WideButton(text: "DAILY!",
                                   action: goToDaily,
                                   sizeWButton: 140,
                                   sizeHButton: 79,
                                   sizeText: 24)
                    }
                }
            }
            .navigationDestination(isPresented: $menuModel.isLevelsAvailible) {
                LevelView()
            }
            
            .navigationDestination(isPresented: $menuModel.isGameAvailible) {
                GameView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MenuView()
}

