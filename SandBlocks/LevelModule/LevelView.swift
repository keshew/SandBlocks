import SwiftUI

struct LevelView: View {
    @StateObject var levelModel =  LevelViewModel()
    var body: some View {
        ZStack {
            Image(levelModel.searchForImage())
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    SmallButton(foregroundImage: ImageName.backArrowImage.rawValue,
                                action: levelModel.goToMenu)
                    Spacer()
                }
                .padding(30)
                
                Text("LEVELS")
                    .Yeast(size: 75)
                
                Spacer()
                HStack {
                    if levelModel.time < 3 {
                        ForEach(0..<3, id: \.self) { row in
                            LevelButton(text: "\(row + 1)",
                                        image: self.levelModel.setupLevel(index: row).0,
                                        action: levelModel.goToGame)
                            .offset(x: CGFloat(50 + row * 5) , y: CGFloat(90 * CGFloat(row - 1)))
                            .disabled(self.levelModel.setupLevel(index: row).1)
                        }
                    } else if levelModel.time > 3, levelModel.time < 7 {
                        ForEach(3..<7, id: \.self) { row in
                            LevelButton(text: "\(row + 1)",
                                        image: self.levelModel.setupLevel(index: row).0,
                                        action: levelModel.goToGame)
                            .offset(x: CGFloat(row * 3 ) , y: CGFloat(100 * CGFloat(row - 5)))
                            .disabled(self.levelModel.setupLevel(index: row).1)
                        }
                    } else if levelModel.time > 6, levelModel.time < 10 {
                        ForEach(6..<10, id: \.self) { row in
                            LevelButton(text: "\(row + 1)",
                                        image: self.levelModel.setupLevel(index: row).0,
                                        action: levelModel.goToGame)
                            .offset(x: CGFloat(row - 10) , y: CGFloat(120 * CGFloat(row - 8)))
                            .disabled(self.levelModel.setupLevel(index: row).1)
                        }
                    } else if levelModel.time > 9, levelModel.time < 12 {
                        ForEach(9..<12, id: \.self) { row in
                            LevelButton(text: "\(row + 1)",
                                        image: self.levelModel.setupLevel(index: row).0,
                                        action: levelModel.goToGame)
                            .offset(x: CGFloat(row - 70) , y: CGFloat(130 * CGFloat(row - 11)))
                            .disabled(self.levelModel.setupLevel(index: row).1)
                        }
                    }
                }
                Spacer()
            }
            .navigationDestination(isPresented: $levelModel.isMenuAvailible) {
                MenuView()
            }
            
            .navigationDestination(isPresented: $levelModel.isGamevailible) {
                GameView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LevelView()
}

