//
//  QuizView.swift
//  DeenOD-App
//
//  Created by McMoodie on 2020-11-14.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.presentationMode) var presentationMode
                
    var selectedQuestions: [Question] = Bundle.main.decode("deenodquestions.json")
    
    init() {
        selectedQuestions = selectedQuestions.shuffled()
    }
    
    @State private var score = 0
    @State private var quizPosition = 0
    @State private var endQuiz = false
       
    var body: some View {
        VStack {
            Text("Score: \(score)")
                .fontWeight(.bold)
                .padding()
            Text(selectedQuestions[quizPosition].question)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            ForEach(selectedQuestions[quizPosition].answers.shuffled(), id: \.self) { answer in
                VStack {
                    Button(action: {
                        checkAnswer(selectedQuestions[quizPosition].correctAnswer, answer)
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                                .foregroundColor(.black)
                                .opacity(0.8)
                            Text(answer)
                                .foregroundColor(.white)
                                .padding()
                        }
                        .frame(width: 250, height: 100)
                    }
                    .alert(isPresented: $endQuiz) {
                        Alert(title: Text("The game has ended\nYour Score is: \(score)"), message: Text("Play Again?"), dismissButton: .destructive(Text("Play Again")) {
                            backToMenu()
                        })
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func checkAnswer(_ cCA: String, _ sA: String) {
        if sA == cCA {
            score += 1
            quizPosition += 1
        } else {
            endQuiz = true
        }
    }
    
    func backToMenu() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

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
//
//struct QuizView: View {
//
//    @State private var endAngle: Double = 270
//    @State private var seconds: Int = 12
//
//    var body: some View {
//        NavigationView {
//            GeometryReader { geo in
//                ZStack {
////                    LinearGradient(gradient: Gradient(colors: [
////                        Color(red: 0.3373, green: 0.1804, blue: 0.1137), //#572E1C
////                        Color(red: 0.4549, green: 0.2549, blue: 0.1451), //#754226
////                        Color(red: 0.4549, green: 0.2863, blue: 0.1216), //#754A1F
////                        Color(red: 0.451, green: 0.3176, blue: 0.098)    //#73521A
////                    ]), startPoint: .top, endPoint: .bottom)
//                    LinearGradient(gradient: Gradient(colors: [
//                        Color(red: 0.2471, green: 0.1961, blue: 0.4039), //#3F3267
//                        Color(red: 0.3608, green: 0.2627, blue: 0.5451), //#5C438B
//                        Color(red: 0.3882, green: 0.2627, blue: 0.5451), //#63438B
//                        Color(red: 0.4235, green: 0.2627, blue: 0.5451)  //#6C438B
//                    ]), startPoint: .top, endPoint: .bottom)
////                    LinearGradient(gradient: Gradient(colors: [
////                        Color(red: 0, green: 0.227, blue: 0.208), //#003A35
////                        Color(red: 0, green: 0.345, blue: 0.318), //#005851
////                        Color(red: 0, green: 0.361, blue: 0.271), //#005C45
////                        Color(red: 0, green: 0.38, blue: 0.227), //#00613A
////                        Color(red: 0, green: 0.4588, blue: 0.286) //#007549
////                    ]), startPoint: .top, endPoint: .bottom)
//                    VStack {
//                        ZStack {
//                            Arc(startAngle: .degrees(0), endAngle: .degrees(endAngle), clockwise: true)
//                                .stroke(Color.white, style: StrokeStyle(lineWidth: 3.5, lineCap: .round, lineJoin: .round))
//                                .frame(width: geo.size.width * 0.2, height: geo.size.height * 0.2)
//                                .padding()
//                                .padding()
//                            Text("\(seconds)")
//                                .foregroundColor(.white)
//                                .font(.custom("CinzelDecorative-Bold", size: 35))
//                        }
//                        .offset(y: 20)
//                        .onTapGesture {
//                                self.seconds -= 1
//                                self.endAngle -= 22.5
//                        }
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 31.0, style: .continuous).stroke(Color.white, lineWidth: 3.5)
//                                .frame(width: geo.size.width * 0.85, height: geo.size.height * 0.65)
//                            VStack {
//                                Text("QUESTION")
//                                    .font(.custom("CinzelDecorative-Bold", size: 20))
//                                    .foregroundColor(.white)
//                                ForEach(0..<3) { number in
//                                    ZStack {
//                                        RoundedRectangle(cornerRadius: 31.0, style: .continuous).stroke(Color.white, lineWidth: 3.5)
//                                            .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.084)
//                                        Text("ANSWER \(number+1)")
//                                            .font(.custom("CinzelDecorative-Bold", size: 20))
//                                            .foregroundColor(.white)
//                                    }
//                                    .offset(y: 70)
//                                }
//                            }
//                        }
//                        Spacer()
//                        HStack {
//                            ForEach(0..<3) { number in
//                                RoundedRectangle(cornerRadius: 31.0, style: .continuous).stroke(Color.white, lineWidth: 3.5)
//                                    .frame(width: 45, height: 25)
//                                    .padding(.horizontal)
//                            }
//                        }
//                        .padding(.bottom)
//                        .offset(y: -20)
//                        Spacer()
//                    }
//                }
//                .edgesIgnoringSafeArea(.all)
//                .navigationBarItems(
//                    leading:
//                        ZStack {
//                            Text("1,800")
//                                .font(.custom("Bahnschrift-Regular", size: 25))
//                                .foregroundColor(.white)
//                            Image("Image14")
//                                .resizable()
//                                .aspectRatio(contentMode: .fill)
//                                .frame(width: 20, height: 25)
//                                .offset(x: -36)
//                        }
//                        .offset(x: 25)
//                        .padding(.top),
//                    trailing:
//                        Image("DeenOD")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 50, height: 40)
//                        .padding(.top)
//                        .offset(x: -10)
//                )
//            }
//        }
//    }
//}
//
//struct QuizView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizView()
//    }
//}
