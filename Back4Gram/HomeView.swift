//
//  HomeView.swift
//  Back4Gram
//
//  Created by Venom on 09/09/19.
//  Copyright © 2019 Venom. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack{
                HStack{
                    Button(action: {}){
                        Image("camera")
                        .resizable()
                        .frame(width: 30, height: 30)
                    }.padding()

                    Text("Back4Gram")
                        .font(.largeTitle)
                        .foregroundColor(lightBlueColor)
                        .fontWeight(.semibold)

                    Spacer()

                    Button(action: {}){
                        Image("home")
                        .resizable()
                        .frame(width: 30, height: 30)
                    }

                    Button(action: {}){
                        Image("paper-plane")
                        .resizable()
                        .frame(width: 30, height: 30)
                    }.padding()

                }.frame(height: 50)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        PreviewViewTop()
                        PreviewViewTop()
                        PreviewViewTop()
                        PreviewViewTop()
                        PreviewViewTop()
                        PreviewViewTop()
                    }
                }.frame(height: 70)
                
                TimelineDetailView().padding(.top, 20)
                
                BottomView()
            }
        }
    }
}


/*
 
 [ GeometryReader ]
 [ 출처 : https://medium.com/hcleedev/swift-geometryreader는-무엇일까-564896c6d6e0 ]
 
 View를 구성할 때 대부분 VStack, HStack, ZStack만 사용해도 그럴듯한 화면을 만들 수 있지만,
 그 이상으로 하위 뷰, Child View들의 위치나 모양을 직접 조작해야 하는 경우가 있다.
 그럴 경우 사용해주는 Container View가 바로 GeometryReader다.
 
 Child View는 별 설정이 없다면 Parent View가 제안해준 위치에 모습을 드러낸다.
 : child view -> view 내부의 객체를 지칭한다.
 
 하지만 Parent View가 제안하는 자리가 마음에 안들 수도 있다.
 그럴 때 Child View는 그 제안을 무시하고 본인이 직접 자신의 위치, 모양 등을 선언할 수 있다.
 Parent View는 제안 정도만 할 수 있는 것이고, 실제 자신의 위치 등에 대한 결정권을 가진 것은 Child View라는 것이다.
 // by modifier?
 이때 Child View는 Parent View가 제안한 위치를 활용할 수 있고, 그를 위해 사용되는 것이 GeometryReader다.
 
 도큐먼트에서 GeometryReader를 소개한 한 문장을 가지고 왔다.
 
 A container view that
 defines its content as a function of
 its own size and coordinate space.
 
 우선 GeometryReader는 그 자체로 ‘View’이며,
 container 안 View 스스로의 크기와 위치를 함수로 정의한다고 소개되어있다.
 
 
 
 1) 원래 방식
 
 /*
  
  struct ContentView: View {
      var body: some View {
          VStack {
              Text("Left Text")
              RightView()
                // 여기서 아래 구조체 (뷰)로 넘기는구만!
                // 이것도 결국 VStack 안에 묶여있어서 하나의 뷰로 취급된다.
          }
      }
  }

  struct RightView: View {
      var body: some View {
          Rectangle()
              .foregroundColor(.blue)
      }
  }
  
  첫번째 코드에선 VStack에 frame같은 특수한 modifier가 붙어있지 않으므로
  이 VStack은 Text를 화면 상단에 위치시키고, 그 밑 남는 모든 화면을 RightView에 할당, 제안해준다.
  그러면 RightView도 딱히 반론이 없으므로, 적당히 화면을 다 채워줄 것이다.
  
  */
 
 
 
 2) GeometryReader 를 사용했을 때
 
 /*
  
  struct ContentView: View {
      var body: some View {
          VStack {
              Text("Left Text")
              RightView()
          }
      }
  }

  struct RightView: View {
      var body: some View {
          GeometryReader { geometry in
              Rectangle()
                  .path(in: CGRect(x: geometry.size.width/2, y: 0,
                                  width: geometry.size.width / 2.0,
                                  height: geometry.size.height / 2.0))
                  .fill(Color.blue)
          }
      }
  }
  
  */
 
 하지만 두 번째 코드는 다르다. VStack은 RightView에게 첫 번째 코드와 똑같은 공간을 제안하겠지만,
 이번엔 RightView에서 본인의 위치를 선택할 권리를 행사했다.
 GeometryReader를 사용해 VStack이 제안한 크기와 위치에 접근할 수 있어,
 VStack이 제안한 높이, 너비를 geometry.size.width와 geometry.size.height로 접근했다.
 이에 접근해 width와 height를 반으로 깎고, 위치는 VStack에서 제안한 너비의 절반 위치로 옮겼다.
 : VStack에서 제안한 너비 == geometry.size.width
 
 
 
 +
 
 GeometryReader가 ‘상위 View가 ContainerView(GeometryReader)에게 제안한
 ’ 위치, 크기에 대한 정보에 접근할 수 있도록 돕는 도구라는 것이다.
 GeometryReader 안에 뷰를 여러개 넣어보면 알겠지만, GeometryReader 내부 View
 하나하나에 제안한 위치, 크기 정보가 아닌 GeometryReader라는 큰 View 자체에 제안된 위치에 접근할 수 있는 것이다.
 --> okay!
 
 
 
 */


/*
 
 GeometryProxy : 2개의 프로퍼티와, 1개의 메소드
 
 public var size: CGSize { get }
 public var safeAreaInsets: EdgeInsets { get }
 public func frame(in coordinateSpace: CoordinateSpace) -> CGRect
 
 
 1) size : Container View의 size. 위 코드 예제에서도 사용했는데, GeometryReader의 크기에 접근할 수 있다.
 
 2) safeAreaInsets : Safe Area 정보에 접근할 수 있다. 이를 이용하면 화면 내의 Safe Area의 크기에도 접근할 수 있다.
 조금 더 자세히 알아보자면, EdgeInsets는 사각형 각 변이 더 큰 사각형 공간의 각 변과 얼마나 떨어져있는지 거리를 나타내고 있는 구조체다.
 우리가 지금껏 이런저런 View들을 집어넣던 사각형 공간의 가장자리에 남는 공간을 정의한다고 생각할 수 있고,
 Safe Area와 연결지어 생각하면 편하다.
 geometry.safeAreaInsets.top 은 스크린 상단과의 거리라고 생각하면 되어서,
 상단 Safe Area의 높이라고 생각할 수 있다.
 
 하지만 safeAreaInsets에서 주의할 점이 있다. GeometryReader라는
 View 자체가 가용할 수 있는 공간 안에서 얼마나 Safe Area의 방해를 받았냐를 알 수 있는 것이라,
 아무데서나 Safe Area의 크기, 상단바의 높이에 접근할 수 있는 것은 아니다.
 
 ! GeometryReader도 하나의 Container View이고,
 그 Container View가 상위 View로부터 제안받은 크기, 위치에 접근하고 있다는 것만 이해하자!
 
 3) frame : ‘Parent View로부터 제안받은 공간'을 사각형(CGRect)로 받을 수 있다.
 저기서 요구하는 CoordinateSpace는 .global, .local, .named로 나뉜다.
 .named의 경우는 커스텀 좌표공간이라 패스하고 .global과 .local만 설명하자면,
 .global은 스크린 전체에 대한 정보를 얻을 수 있는 좌표 공간이고,
 .local은 계층 상 가장 가까운 Container View가 제안 받은 위치에 대한 정보를 얻을 수 있는 좌표 공간이다.
 즉, 이 메서드를 사용하면 .local은 GeometryReader의 좌표 공간을 뜻한다.
 
 하지만 GeometryReader를 너무 남용하지 말자
 이렇게 보면 꽤 강력하고 좋은 도구 같지만, 많은 문서에서 GeometryReader를 남발하는 것은 추천하지 않는다.
 
 이유를 정확히 설명하긴 어렵지만, 사용하다보면 GeometryReader를 넣은 View가 레이아웃이 박살나거나, View가 제 기능을 못할 때가 있다.
 예전에 ScrollView였나, GeometryReader랑 같이 사용하다 스크롤이 제대로 되지 않아 원인을 찾다 GeometryReader를 지우니
 바로 해결된 적이 있었다.
 
 아무래도 GeometryReader를 쓰면 Alignment나 기능이 제대로 실행안되거나 하는 문제가 있어서,
 반드시 GeometryReader의 기능이 필요할 때만 사용하는 것이 좋다.
 또한, 사용할 때 GeometryReader의 사이즈는 .frame modifier 등을 이용해
 (GeometryReader의 메서드가 아닌, View의 modifier) 크기를 정확히 정해주고 사용하면
 의도치 않은 결과를 방지할 수 있다. 그리고 가급적이면 가장 상위 View,
 화면 전체를 뒤덮는 View에서 적용하는게 좋다.
 

 */


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}




// 얜 정체가 뭘 까. .
// HomeView 내부에 HStack으로 쌓임!
// 동그라미 스토리 프로필 사진들!

struct PreviewViewTop: View {
    var body: some View {
        ZStack(alignment: .bottom){
            HStack{
                VStack {
                    Image("logo-social")
                    .resizable()
                    .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .shadow(radius: 3)
                        .overlay(Circle().stroke(Color.pink, lineWidth: 1))
                    
                    Text("Your Stories")
                        .font(.caption)
                }
            }
        }
    }
}
