//
//  ContentView.swift
//  Back4Gram
//
//  Created by Venom on 22/08/19.
//  Copyright © 2019 Venom. All rights reserved.
//

import SwiftUI
import Apollo

struct ContentView : View {
    var body: some View {
        //ProfileView()
        HomeView()
    }
}

// 컨텐츠 뷰: 화면을 그리는 구조체
// 프리뷰 : 프리뷰를 그리는 구조체

/*
 
 - text 밑에 .을 통하여 속성들을 나열하는 것
 : modifier 라고 부른다!
 ex) .font, .fontWeight, .padding 등등
 
 
 
 */


/*
 
 [ some 은 무엇인가 ? ]
 [ 출처: https://babbab2.tistory.com/158 ]
 
 some이라는 키워드는 Swift 5.1에서 등장한 새로운 기능으로,
 해당 키워드가 반환 타입 앞에 붙을 경우,
 해당 반환 타입이 불투명한 타입(Opaque Type)!
 : 불투명한 타입이란 -> "역 제네릭 타입(reverse generic types)

 위에서 제네릭이 함수 "외부"에서 해당 타입에 대해 알 수 있는 반면,
 불투명한 타입의 경우, 외부에서 함수의 반환 값 유형을 정확하게 알 수 없음
 다만 함수 내부에서는 어떤 타입을 다루는지 정확히 알고 있음 (그러게, 정확히 반대네..?)
 
 ---
 
 명확하지 않은 타입(associatedType or Self)이 프로토콜 내에 정의되어 있고,
 이 프로토콜을 함수(및 연산 프로퍼티)의 반환 타입으로 가질 때
 반환 타입을 "불투명 타입"으로 만들어주기 위해 사용하고,
 : 반환 값 유형을 정확하게 알 수 없다!
  
 some이라는 것을 통해 반환 타입을 "불투명 타입"으로 만든단 것은,
 반환 타입이 어떤 타입인지 컴파일러(및 함수 외부)는 1도 모르겠지만
 함수 내부에선 어떤 타입을 반환하는지 명확히 알고 있고, (내부는 알고있다!)
 따라서 내 함수는 정해진 "특정 타입만 반환"된다고 컴파일러에게 알려주는 것임
 // 후.. 어렵다.. 머리 터진다. .으 ㅏ아
  
 위 예제에서 "특정 타입"은 함수 내부에서 어떻게 구현하냐에 따라 달라지겠지만,
 GiftBox 프로토콜을 준수하고 있는 AppleGiftBox / CherryGiftBix 중 하나가 될 것임

 */

/*
 
 [ some 을 사용할 때의 이점! ]
 
 여기서 body라는 것은 View라는 프로토콜에 정의된 프로퍼티인데,
 이 프로퍼티는연산 프로퍼티(Computed Property)로
 위 코드에선 Text라는 것을 return 하고 있다고 보면 됨
  
 자, 근데 위에서 배운 것을 토대로 한다면
 some은 언제쓴다??
  
 명확하지 않은 타입(associatedType or Self)이 프로토콜 내에 정의되어 있고,
 이 프로토콜을 반환 타입으로 가지고 싶을 때 쓴다!!!
  
 오홍 그럼 View는 프로토콜일 것이고!!! 속성 중 하나는 associatedtype(or Self)로 선언되어 있겠네!?
 
 
 public protocol View {

     /// The type of view representing the body of this view.
     ///
     /// When you create a custom view, Swift infers this type from your
     /// implementation of the required ``View/body-swift.property`` property.
     
    associatedtype Body : View

     /// The content and behavior of the view.
     ///
     /// When you implement a custom view, you must implement a computed
     /// `body` property to provide the content for your view. Return a view
     /// that's composed of built-in views that SwiftUI provides, plus other
     /// composite views that you've already defined:
     ///
     ///     struct MyView: View {
     ///         var body: some View {
     ///             Text("Hello, World!")
     ///         }
     ///     }
     ///
     /// For more information about composing views and a view hierarchy,
     /// see <doc:Declaring-a-Custom-View>.
     @ViewBuilder var body: Self.Body { get }
 }
 
 
 
 // body가 associatedtype 으로 view (프로토콜) 내부에 정의되어 있음
 이를 반환 타입으로 갖고 싶을 때
 명확하지 않은 타입(associatedType or Self)이 프로토콜 내에 정의되어 있고,
 이 프로토콜을 반환 타입으로 가지고 싶을 때 some을 쓴다! :)
 
 
 */


/*

 [정리]
 
 그럼 body라는 연산 프로퍼티는 View라는 프로토콜 타입을 반환하지만
 View라는 프로토콜 내에 명확하지 않은 타입(body)이 정의되어 있으니
 some을 통해 불투명 타입이라고 밝혀준 것이구나!
  
 따라서 body 내부에 내가 작성하는 코드에 따라 리턴 타입이 달라지겠지만,
 View 프로토콜을 준수하는 타입만 리턴이 가능하겠군!
 
 
 
 ( if text -> button )
 
 컴파일러(및 함수 외부)에서는 View라는 프로토콜을 준수하는 객체가 나올 것은 알지만,
 정확히 어떤 타입이 나올지는 모름
 다만 위에서 body는 특정 타입(현재는 내가 Text를 리턴 했으니 Text)만
 항상 반환된단 것을 알려주는 것이 some(불투명 타입)임
  
 엥 갑자기 기획자가 내부 디자인을 Text가 아닌 버튼으로 바꿔달라네?
 
 이렇게 text를 Button으로 바꾸면 컴파일러 및 함수 외부에선
 여전히 정확히 어떤 타입이 나올지는 모름
 다만 위에서 body는 특정 타입(현재는 내가 Button를 리턴 했으니 Button)만
 항상 반환된단 것을 알려주는 것이 some(불투명 타입)임
 
 
 
 [ summary ]
 
 이렇게 불투명한 타입(some)을 사용할 경우,
 함수 내부에서 내가 짜는 코드에 따라 시시각각 리턴 타입이 변경 되었지만 (Text -> Button)
 이거에 대해 따로 내가 리턴 타입을 바꿔줄 필요가 없음!!!
 
 만약 some을 통해 불투명 타입으로 선언하지 않았다면
 매번 body의 타입을 저렇게 다 끔찍하게 명명해줬어야 했을 거임
 한마디로 불필요한 타입에 대해 우리가 알 필요가 없음! 컴파일러가 알아서 함
 -> 쉽게 ui 요소들을 구성하기 위해, 사용성을 높이는 역할을 하는 듯 하다.
 
 
  */



#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        // previews : PreviewProvider 프로토콜의 필수 구현 사항
        // previews 타입 프로퍼티에서 뷰 생성
        
        ContentView()
        // 얘도 결국 홈 뷰 생성으로 이어지겠지?
    }
}
#endif


/*
 
 public protocol PreviewProvider : _PreviewProvider {

     /// The type to preview.
     ///
     /// When you create a preview, Swift infers this type from your
     /// implementation of the required
     /// ``PreviewProvider/previews-swift.type.property`` property.
 
     associatedtype Previews : View

     /// A collection of views to preview.
     ///
     /// Implement a computed `previews` property to indicate the content to
     /// preview. Xcode generates a preview for each view that you list. You
     /// can apply ``View`` modifiers to the views, like you do
     /// when creating a custom view. For a preview, you can also use
     /// various preview-specific modifiers that customize the preview.
     /// For example, you can choose a specific device for the preview
     /// by adding the ``View/previewDevice(_:)`` modifier:
     ///
     ///     struct CircleImage_Previews: PreviewProvider {
     ///         static var previews: some View {
     ///             CircleImage()
     ///                 .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch)"))
     ///         }
     ///     }
     ///
     /// For the full list of preview-specific modifiers,
     /// see <doc:Previews-in-Xcode>.
 
     @ViewBuilder static var previews: Self.Previews { get }

     /// The platform on which to run the provider.
     ///
     /// Xcode infers the platform for a preview based on the currently
     /// selected target. If you have a multiplatform target and want to
     /// suggest a particular target for a preview, implement the
     /// `platform` computed property to provide a hint,
     /// and specify one of the ``PreviewPlatform`` values:
     ///
     ///     struct CircleImage_Previews: PreviewProvider {
     ///         static var previews: some View {
     ///             CircleImage()
     ///         }
     ///
     ///         static var platform: PreviewPlatform? {
     ///             PreviewPlatform.tvOS
     ///         }
     ///     }
     ///
     /// Xcode ignores this value unless you have a multiplatform target.
     static var platform: PreviewPlatform? { get }
 }
 
 */


/*
 
 [ content view 이해하기 ]
 [ 출처: https://babbab2.tistory.com/159?category=829015 ]
 
 1) body는 단 한개의 View만 반환 !
 : 여러개의 text를 배치하고 싶을 땐, 꼭 stack으로 묶어줘야 함
 : 즉, 여러 개의 뷰들을 하나의 뷰로 감싸줘서 하나의 View로 리턴해야 함!!!
 - 실제 위 코드에서 body의 타입은 VStack<TupleView<Text,Text>>으로
   body는 VStack이라는 하나의 View로 반환되는 것임!
 - 다만 우린 위의 복잡한 타입에 대해 알 필요 없고 명시할 필요도 없다!
 -> body가 some View 즉, 불투명 타입을 리턴하니까! 하하
 
 2) ContentView에 변수나 상수를 추가 ?
 -> body 위에다가 해주면 된다!
 
 /*
  
  struct ContentView : View {
      var name: "Colli"
      var body: some View {
          Text("Hello")
      }
  }
  
  */
 
 
 3) View의 생애주기를 관리하고 싶다면 ?

  
 그.. UIKit으로 개발할 때 사용하는 View Controller의 생애주기 있잖음?
  
 ViewDidAppear
 ViewDidDisappear
 ...
  
 등등.. 이런 거 어떻게 사용하냐면
  
 onAppear
 onDisappear
  
 라는 modifier를 이용하면 됨!! :)
 
 /*
  
  struct ContentView : View {
      var body: some View {
          Text("Hello")
          .onAppear {
              print("텍스트가 보입니다")
          }
      }
  }
  
  */
  
 등등 이런 식으로!
 
 
 +
 
 + 참고로
 위의 body 프로퍼티는 View가 생성되고 한 번만 만들어지는 게 아니라
 View의 Life Cycle 동안 필요할 때마다 여러 번씩 새로 만들어져서 리턴됨
  
 그럼 성능에 ㄱㅐ문제있는 거 아닌가요? 싶겠지만,
 SwiftUI에선 View 자체가 클래스가 아닌 구조체로 매우매우 가벼워 ok
 
 
 */
