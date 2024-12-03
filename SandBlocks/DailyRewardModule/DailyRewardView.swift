import SwiftUI

struct DailyRewardView: View {
    @StateObject var dailyRewardModel =  DailyRewardViewModel()
    @Binding var showDaily: Bool
    @State var rotation: Double = 0.0
    @State var isAnimating = false
    
    func startRotating() {
        withAnimation(Animation.linear(duration: 2).repeatCount(1, autoreverses: false)) {
            rotation = 180 // Вращение на 360 градусов
        }
    }
    
    func goToDaily() {
        showDaily = false
    }
    

    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
            .ignoresSafeArea()
            
            VStack {
                HStack {
                    SmallButton(foregroundImage: ImageName.backArrowImage.rawValue,
                                action: goToDaily)
                    Spacer()
                }
                .padding()
                
                Text("DAILY")
                    .Yeast(size: 60)
                
                Text("REWARD")
                    .Yeast(size: 60, color: .white)
                
                HStack {
                    ZStack {
                        Image(ImageName.currenTimeBackgroundImage.rawValue)
                            .resizable()
                            .frame(width: 162, height: 78)
                        
                        HStack {
                            Image(ImageName.coinCount.rawValue)
                                .resizable()
                            .frame(width: 24, height: 24)
                            
                            Text("REWARD: 1000")
                                .Yeast(size: 15)
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
                            
                            Text("COIN: 1000")
                                .Yeast(size: 20)
                        }
                    }
                }
                Spacer()
                ZStack {
                    Image(ImageName.fortune.rawValue)
                        .resizable()
                        .frame(width: 404, height: 404)
                        .offset(y: 150)
                    
                    Image(ImageName.numbers.rawValue)
                        .resizable()
                        .frame(width: 404, height: 384)
                        .offset(y: 150)
//                        .rotationEffect(.degrees(rotation))
//                        .onAppear {
//                            startRotating()
//                        }
                    
                    Image(ImageName.borderFortune.rawValue)
                        .resizable()
                        .offset(y: 150)
                        .frame(width: 424, height: 424)
                    
                    Image(ImageName.pick.rawValue)
                        .resizable()
                        .offset(y: -40)
                        .frame(width: 85, height: 113)
                    
                    WideButton(text: "SPIN",
                               action: startRotating,
                               sizeWButton: 140,
                               sizeHButton: 79,
                               sizeText: 24)
                    .offset(y: 200)
                }
                
            }
        }
    }
}


