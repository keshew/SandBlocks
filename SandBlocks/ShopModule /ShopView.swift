import SwiftUI

struct ShopView: View {
    @StateObject var shopModel =  ShopViewModel()
    @Binding var showShop: Bool
    
    func goToShop() {
        showShop = false
    }
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
            .ignoresSafeArea()
            
            VStack {
                VStack {
                    HStack {
                        SmallButton(foregroundImage: ImageName.backArrowImage.rawValue,
                                    action: goToShop)
                        Spacer()
                    }
                    .padding()
                    
                    Text("SHOP")
                        .Yeast(size: 104)
                    ZStack {
                        Image(ImageName.currenTimeBackgroundImage.rawValue)
                            .resizable()
                            .frame(width: 211, height: 102)
                        
                        Image(ImageName.coinCount.rawValue)
                            .resizable()
                            .frame(width: 41, height: 41)
                            .offset(x: -60)
                        
                        Text("COIN: \(shopModel.coin ?? 0)")
                            .Yeast(size: 24)
                            .offset(x: 20)
                    }
                    
                    ZStack {
                        Image(ImageName.shopItemBackground.rawValue)
                            .resizable()
                            .frame(width: 354, height: 356)
                        
                        VStack(spacing: 15) {
                            Text(shopModel.swipeDirection.0)
                                .Yeast(size: 24)
                            
                            HStack {
                                Image(shopModel.swipeDirection.1)
                                    .resizable()
                                    .frame(width: 71, height: 71)
                                    .offset(x: -10)
                                
                                Text("X 1")
                                    .Yeast(size: 35)
                            }
                            
                            HStack {
                                Text("COST: 30")
                                    .Yeast(size: 25)
                                
                                Image(ImageName.coinCount.rawValue)
                                    .resizable()
                                    .frame(width: 41, height: 41)
                                
                            }
                        }
                        
                        Button(action: {
                        
                        }) {
                            WideButton(text: "BUY",
                                       action: shopModel.goToMenu,
                                       sizeWButton: 140,
                                       sizeHButton: 79,
                                       sizeText: 24)
                        }
                        .offset(y: 155)
                    }
                    Spacer()
                    Text(shopModel.swipeDirection.2)
                        .Yeast(size: 32)
                }
            }
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width > 0 {
                        shopModel.swipeDirection = shopModel.changeView(with: true)
                    } else {
                        shopModel.swipeDirection = shopModel.changeView(with: false)
                    }
                }
        )
    }
}

//#Preview {
//    ShopView()
//}

