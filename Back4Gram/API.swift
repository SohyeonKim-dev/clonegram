//  This file was automatically generated and should not be edited.



/*
 
[ delegate pattern 적용 ]
[ 출처 : https://taekki-dev.tistory.com/36 ]
 
 
 크게 상품 화면과 장바구니 담기 화면 2가지로 구성

 1) 상품 화면에서 장바구니 버튼을 클릭
 2) 장바구니 담기 화면으로 이동
 3) 개수를 선택하고 장바구니 담기 버튼 클릭
 4) 장바구니 담기 화면이 사라지면서 상품을 몇 개 추가했는지 알림 호출
 
 
 ** A(상품 화면) → B(장바구니 담기 화면)
  
 다음과 같은 흐름일 때,
  
 A(상품 화면)에서 B(장바구니 담기 화면)로 데이터(상품 이름, 가격)를 넘겨주는 것은
 프로퍼티로 넘겨주면 되니까 어렵지 않은데, B(장바구니 담기 화면)에서 A(상품 화면)로
 데이터(상품 몇 개 담았는지 상품 개수)를 넘겨주려고 하니 단순히 프로퍼티에 넘겨주는 방식으로는 구현이 안됨
  
 어떻게 해야 할까요? 정말 여러가지 방법으로 처리할 수 있습니다.
 사실 정말 간단하게 클로저(Closure)로 처리할 수도 있지만 이번에 우리는
 델리게이트 패턴(Delegate Pattern)을 이용해서 한 번 처리해보겠습니다.
 
 1) CartDelegate : 상품 관련 처리를 위한 프로토콜
 2) ViewController : 상품 뷰 컨트롤러(화면)
 3) CartViewController : 장바구니 담기 뷰 컨트롤러(화면)
 
 
 자 구성이 이해가 되었으면 다음으로 크게 3가지를 신경 쓸 거예요.
  
 - 프로토콜(Protocol) - 작업의 설계도
 - 신호를 주는 쪽(Sender)
 - 신호를 받고 처리할 쪽(Receiver)

 
 
 
 
 
 
 
 1. 프로토콜 - 작업의 설계도
 
 // CartDelegate.swift
 
 import Foundation

 protocol CartDelegate {
     func alarmCartIsFilled(itemCount: Int)
 }
 
 여기서 중요한 것은 프로토콜에서는 직!접! 구현을 하지 않는다는 것!
 장바구니에 상품이 채워졌을 때 어떤 액션을 처리하고 싶은 것인데요.
 그와 관련된 메서드를 1가지 만듦 : alarmCartIsFilled 함수!
 
 
 
 
 2. 신호를 주는 쪽 - CartViewController(장바구니 담기 뷰 컨트롤러)

 신호를 주는 쪽은 CartViewController입니다.
 몇 개의 상품이 추가되었는지 신호(데이터, 알림 등)를 누군가에게 알려주고 싶은 거예요.
 중요한 부분만 같이 살펴봅시다.
 
 
 class CartViewController: UIViewController {
     // ...
     var delegate: CartDelegate?     // 객체가 가지는 어떤 권한
     // ...

     // ...
     @IBAction func insertCartButtonTapped(_ sender: UIButton) {
         dismiss(animated: true, completion: nil)
         delegate?.alarmCartIsFilled(itemCount: itemCount)
         // 권한 중에 이런 액션을 실행할거야, 이런 요청을 날릴거야
     }
     // ...
 }
 
  
 delegate 변수를 하나 만들어주었어요.
 이 친구는 우리가 아까 만들어 둔 CartDelegate 프로토콜을 채택하고 있죠.
 복잡하게 말고 간단하게 어떤 권한을 만들어주엇다고 생각해봅시다.
  
 ✅ 이제 CartViewController에는 CartDelegate 프로토콜에 대한 권한이 생겼어요.
  
 장바구니 담기 버튼(insertCartButton)을 클릭했을 때 프로토콜 중 alarmCartIsFilled()라는 기능을 사용하고 싶어요.
 인자로는 상품의 개수(itemCount)를 넘겨주고 있어요.
 메서드 안에서 상품의 개수를 이용해 무언가를 요리조리 처리하고 싶은 거예요.
  
 기능을 실행시키기는 할 건데 이것도 신호의 일종으로 생각해서 신호를 받는 쪽으로 권한이나 이런 것들을 다 넘겨줄 거예요.
 (실행시킬거야 근데 어떤 기능인지는 구현하는 쪽에서 찾아봐 ~ 이런 느낌??)
 
 
 
 
 
 
 */



import Apollo

public final class SignUpUserMutation: GraphQLMutation {
  /// mutation signUpUser($username: String!, $password: String!, $email: String) {
  ///   users {
  ///     __typename
  ///     signUp(fields: {username: $username, password: $password, email: $email}) {
  ///       __typename
  ///       objectId
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "mutation signUpUser($username: String!, $password: String!, $email: String) { users { __typename signUp(fields: {username: $username, password: $password, email: $email}) { __typename objectId } } }"

  public let operationName = "signUpUser"

  public var username: String
  public var password: String
  public var email: String?

  public init(username: String, password: String, email: String? = nil) {
    self.username = username
    self.password = password
    self.email = email
  }

  public var variables: GraphQLMap? {
    return ["username": username, "password": password, "email": email]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("users", type: .object(User.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(users: User? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "users": users.flatMap { (value: User) -> ResultMap in value.resultMap }])
    }

    /// This is the top level for users mutations.
    public var users: User? {
      get {
        return (resultMap["users"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "users")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes = ["UsersMutation"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("signUp", arguments: ["fields": ["username": GraphQLVariable("username"), "password": GraphQLVariable("password"), "email": GraphQLVariable("email")]], type: .nonNull(.object(SignUp.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(signUp: SignUp) {
        self.init(unsafeResultMap: ["__typename": "UsersMutation", "signUp": signUp.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The signUp mutation can be used to sign the user up.
      public var signUp: SignUp {
        get {
          return SignUp(unsafeResultMap: resultMap["signUp"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "signUp")
        }
      }

      public struct SignUp: GraphQLSelectionSet {
        public static let possibleTypes = ["SignUpResult"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("objectId", type: .nonNull(.scalar(GraphQLID.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(objectId: GraphQLID) {
          self.init(unsafeResultMap: ["__typename": "SignUpResult", "objectId": objectId])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// This is the object id.
        public var objectId: GraphQLID {
          get {
            return resultMap["objectId"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "objectId")
          }
        }
      }
    }
  }
}

public final class LogInUserMutation: GraphQLMutation {
  /// mutation logInUser($username: String!, $password: String!) {
  ///   users {
  ///     __typename
  ///     logIn(username: $username, password: $password) {
  ///       __typename
  ///       sessionToken
  ///     }
  ///   }
  /// }
  public let operationDefinition =
    "mutation logInUser($username: String!, $password: String!) { users { __typename logIn(username: $username, password: $password) { __typename sessionToken } } }"

  public let operationName = "logInUser"

  public var username: String
  public var password: String

  public init(username: String, password: String) {
    self.username = username
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["username": username, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("users", type: .object(User.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(users: User? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "users": users.flatMap { (value: User) -> ResultMap in value.resultMap }])
    }

    /// This is the top level for users mutations.
    public var users: User? {
      get {
        return (resultMap["users"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "users")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes = ["UsersMutation"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("logIn", arguments: ["username": GraphQLVariable("username"), "password": GraphQLVariable("password")], type: .nonNull(.object(LogIn.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(logIn: LogIn) {
        self.init(unsafeResultMap: ["__typename": "UsersMutation", "logIn": logIn.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The logIn mutation can be used to log the user in.
      public var logIn: LogIn {
        get {
          return LogIn(unsafeResultMap: resultMap["logIn"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "logIn")
        }
      }

      public struct LogIn: GraphQLSelectionSet {
        public static let possibleTypes = ["Me"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("sessionToken", type: .nonNull(.scalar(String.self))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(sessionToken: String) {
          self.init(unsafeResultMap: ["__typename": "Me", "sessionToken": sessionToken])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The user session token
        public var sessionToken: String {
          get {
            return resultMap["sessionToken"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "sessionToken")
          }
        }
      }
    }
  }
}

public final class LogOutUserMutation: GraphQLMutation {
  /// mutation logOutUser {
  ///   users {
  ///     __typename
  ///     logOut
  ///   }
  /// }
  public let operationDefinition =
    "mutation logOutUser { users { __typename logOut } }"

  public let operationName = "logOutUser"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("users", type: .object(User.selections)),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(users: User? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "users": users.flatMap { (value: User) -> ResultMap in value.resultMap }])
    }

    /// This is the top level for users mutations.
    public var users: User? {
      get {
        return (resultMap["users"] as? ResultMap).flatMap { User(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "users")
      }
    }

    public struct User: GraphQLSelectionSet {
      public static let possibleTypes = ["UsersMutation"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("logOut", type: .nonNull(.scalar(Bool.self))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(logOut: Bool) {
        self.init(unsafeResultMap: ["__typename": "UsersMutation", "logOut": logOut])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// The logOut mutation can be used to log the user out.
      public var logOut: Bool {
        get {
          return resultMap["logOut"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "logOut")
        }
      }
    }
  }
}
