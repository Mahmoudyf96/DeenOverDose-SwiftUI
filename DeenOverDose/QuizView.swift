//
//  QuizView.swift
//  DeenOD-App
//
//  Created by McMoodie on 2020-11-14.
//

import SwiftUI

extension Color {
    static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let quizAnswersColour = Color("quizTextColour")
}

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var score = 0
    @State private var quizPosition = 0
    @State private var answer1 = false
    @State private var answer2 = false
    @State private var answer3 = false
    
    @State private var timesUp = false
    
    @State var timeRemaining = 12
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [
                        Color(red: 0.004, green: 0.608, blue: 0.302), //019B4D
                        Color(red: 0.004, green: 0.482, blue: 0.239), //017B3D
                        Color(red: 0, green: 0.345, blue: /*0.32*/ 0.169), //00582B
                        Color(red: 0, green: 0.224, blue: /*0.32*/ 0.111) //00391C
                    ]), startPoint: .top, endPoint: .bottom)
                    VStack {
                        HStack {
                            Spacer()
                                .frame(width: geo.size.width / 2.8)
                            HStack {
                                Text(":")
                                    .kerning(-geo.size.height / 55.0)
                                    .font(.custom("PressStart2P-Regular", size: geo.size.height / 28.0))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                Text("\(timeRemaining)")
                                    .kerning(-1)
                                    .font(.custom("PressStart2P-Regular", size: geo.size.height / 28.0))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .onReceive(timer) { _ in
                                        if self.timeRemaining > 0 {
                                            self.timeRemaining -= 1
                                        } else {
                                            timesUp.toggle()
                                        }
                                    }
                            }
                            .frame(width: geo.size.width / 4.0)
                            Spacer()
                                .frame(width: geo.size.width / 4.8)
                            Image("exitButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width / 14.0)
                            Spacer()
                                .frame(width: geo.size.width / 10.0)
                        }
                        .padding(.top, geo.size.height / 10)
                        Spacer()
                            .frame(height: geo.size.height / 30)
                        Text("During which Caliph’s reign did the Muslims conquer Jerusalem?")
                            .font(.custom("Bungee-Regular", size: geo.size.height / 35.0))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: geo.size.width / 1.2, height: geo.size.height / 3)
                        Spacer()
                            .frame(height: geo.size.height / 30)
                        VStack {
                            Button(action: {
                                answer1.toggle()
                            }) {
                                ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                    Image(answer1 ? "correctQuizButton" : "quizButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geo.size.width / 1.3)
                                    Text("‘Umar")
                                        .font(.custom("PressStart2P-Regular", size: geo.size.height / 40.0))
                                        .foregroundColor(.quizAnswersColour)
                                        .multilineTextAlignment(.center)
                                        .offset(x: geo.size.width / 15.0)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.bottom, 10.0)
                            Button(action: {
                                answer2.toggle()
                            }) {
                                ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                    Image(answer2 ? "wrongQuizButton" : "quizButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geo.size.width / 1.3)
                                    Text("‘Ali")
                                        .font(.custom("PressStart2P-Regular", size: geo.size.height / 40.0))
                                        .foregroundColor(.quizAnswersColour)
                                        .multilineTextAlignment(.center)
                                        .offset(x: geo.size.width / 15.0)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                            .padding(.bottom, 10.0)
                            Button(action: {
                                answer3.toggle()
                            }) {
                                ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                    Image(answer3 ? "wrongQuizButton" : "quizButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geo.size.width / 1.3)
                                    Text("‘Uthman")
                                        .font(.custom("PressStart2P-Regular", size: geo.size.height / 40.0))
                                        .foregroundColor(.quizAnswersColour)
                                        .multilineTextAlignment(.center)
                                        .offset(x: geo.size.width / 15.0)
                                }
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                        Spacer()
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previews: some View {
        QuizView()
    }
}


//        VStack {
//            Text("Score: \(score)")
//                .fontWeight(.bold)
//                .padding()
//            Text(selectedQuestions[quizPosition].question)
//                .fontWeight(.bold)
//                .multilineTextAlignment(.center)
//                .padding()
//            ForEach(selectedQuestions[quizPosition].answers.shuffled(), id: \.self) { answer in
//                VStack {
//                    Button(action: {
//                        checkAnswer(selectedQuestions[quizPosition].correctAnswer, answer)
//                    }) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
//                                .foregroundColor(.black)
//                                .opacity(0.8)
//                            Text(answer)
//                                .foregroundColor(.white)
//                                .padding()
//                        }
//                        .frame(width: 250, height: 100)
//                    }
//                    .alert(isPresented: $endQuiz) {
//                        Alert(title: Text("The game has ended\nYour Score is: \(score)"), message: Text("Play Again?"), dismissButton: .destructive(Text("Play Again")) {
////                            backToMenu()
//                        })
//                    }
//                    .padding()
//                }
//            }
//        }
//        .navigationBarTitle("")
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
//    }

//    func checkAnswer(_ cCA: String, _ sA: String) {
//        if sA == cCA {
//            score += 1
//            quizPosition += 1
//        } else {
//            endQuiz = true
//        }
//    }
//
//    func backToMenu() {
//        self.presentationMode.wrappedValue.dismiss()
//    }
//}

//struct Arc: InsettableShape {
//    var startAngle: Angle
//    var endAngle: Angle
//    var clockwise: Bool
//    var insetAmount: CGFloat = 0
//
//    var animatableData: Angle{
//        get { endAngle }
//        set { self.endAngle = newValue }
//    }
//
//    func path(in rect: CGRect) -> Path {
//        let rotationAdjustment = Angle.degrees(90)
//        let modifiedStart = startAngle - rotationAdjustment
//        let modifiedEnd = endAngle - rotationAdjustment
//
//        var path = Path()
//
//        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: !clockwise)
//        return path
//    }
//
//    func inset(by amount: CGFloat) -> some InsettableShape {
//        var arc = self
//
//        arc.insetAmount += amount
//        return arc
//    }
//}

//                    LinearGradient(gradient: Gradient(colors: [
//                        Color(red: 0.3373, green: 0.1804, blue: 0.1137), //#572E1C
//                        Color(red: 0.4549, green: 0.2549, blue: 0.1451), //#754226
//                        Color(red: 0.4549, green: 0.2863, blue: 0.1216), //#754A1F
//                        Color(red: 0.451, green: 0.3176, blue: 0.098)    //#73521A
//                    ]), startPoint: .top, endPoint: .bottom)
//                    LinearGradient(gradient: Gradient(colors: [
//                        Color(red: 0.2471, green: 0.1961, blue: 0.4039), //#3F3267
//                        Color(red: 0.3608, green: 0.2627, blue: 0.5451), //#5C438B
//                        Color(red: 0.3882, green: 0.2627, blue: 0.5451), //#63438B
//                        Color(red: 0.4235, green: 0.2627, blue: 0.5451)  //#6C438B
//                    ]), startPoint: .top, endPoint: .bottom)
//                    LinearGradient(gradient: Gradient(colors: [
//                        Color(red: 0, green: 0.227, blue: 0.208), //#003A35
//                        Color(red: 0, green: 0.345, blue: 0.318), //#005851
//                        Color(red: 0, green: 0.361, blue: 0.271), //#005C45
//                        Color(red: 0, green: 0.38, blue: 0.227), //#00613A
//                        Color(red: 0, green: 0.4588, blue: 0.286) //#007549
//                    ]), startPoint: .top, endPoint: .bottom)
