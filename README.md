# SwiftUI Component
> SwiftUI 로 UI 를 개발하면서 "반복되고 공통적인 코드들을 어떻게하면 관리하기 편할까?" 와 "어떻게 하면 Preview 를 잘활용할까?" 등의 고민하고 개발한 결과물들을 공유합니다.

<br>

## GIF Summary
<table>
  <tr>
    <td align="center"><b>AppDialog</b></td>
    <td align="center"><b>AppToast</b></td>
    <td align="center"><b>AppButton</b></td>
    <td align="center"><b>AppColor</b></td>
    <td align="center"><b>AppFont</b></td>
  </tr>
  <tr>
    <td><img src="SwiftUIComponent/res/gif/AppDialog.gif" width="160"/></td>
    <td><img src="SwiftUIComponent/res/gif/AppToast.gif" width="160"/></td>
    <td><img src="SwiftUIComponent/res/gif/AppButton.gif" width="160"/></td>
    <td><img src="SwiftUIComponent/res/gif/AppColor.gif" width="160"/></td>
    <td><img src="SwiftUIComponent/res/gif/AppFont.gif" width="160"/></td>
  </tr>
</table>
<br>

## Dialog Component
> SwiftUI 에서 가장 일반적인 예제로 Dialog 를 보여주는 형태가 `Bool` 상태 변수를 이용하여 보여주는 방식입니다.
> 과거에 이 방식을 채택하여 `@EnvironmentObject` 를 활용해 컴포넌트로 개발했었습니다.
> 그런데 이도 역시 Dialog 를 띄우는 화면에 `@EnvironmentObject` 를 세팅하는 코드가 들어가야 했습니다.
> 이를 해결하기 위해 "Dialog 를 보여주는 방식만 UIKit 으로 적용하고 UI 는 SwiftUI 로 개발하면 어떨까?" 라는 생각으로 만들었습니다.
> 이렇게 하면 `UIApplication.showDialog{...}` UIKit 코드에 SwiftUI Dialog 를 할당해서 출력 할 수 있습니다.
> 또 Dialog 를 출력할 때 `Bool` 상태 변수, `@EnvironmentObject` 와 같은 상태관리 코드를 사용하지 않고 독립적으로 출력할 수 있습니다.

- How to use
  ``` swift
  UIApplication.showDialog { dismiss in
      AppDialog(
          model: AppDialogModel(
              title: "코드 리뷰",
              content: "어떤 코드가 좋은 코드일까요?",
              confirmBtnTitle: "생각해볼게요",
              cancelBtnTitle: "몰라요"
          ),
          dismiss: dismiss
      )
  } // : Dialog
  ```

<br>

## Toast 활용
> SwiftUI 로 개발할 때 `Preview` 에서 이벤트 발생 시 바로 확인하기가 어려웠습니다.
> 그렇다고 그 때마다 새로운 UI 로 디버깅하는 방법도 한계가 있었습니다.
> 이를 해결하기 위해서 Toast 를 개발하게 되었습니다.
> `Preview` 에서 이벤트 발생 여부를 확인하기 위해 `UIApplication.makeToast(message)` 를 활용합니다.

- How to use
  ``` swift
  UIApplication.makeToast("Hello, World!")
  ```

<br>

## Button Component
> Button 에 동작이 동일하고 크기, 컬러, 종류가 다를 때 공통으로 사용하기 위해 컴포넌트로 만들었습니다. 자주 사용되는 버튼을 컴포넌트로 만들어 개발 속도 향상 및 유지보수가 개선되었습니다.
- How to use
  ``` swift
  ScrollView (showsIndicators: false) {
      VStack(alignment: .leading, spacing: spacing) {
          ForEach(AppButtonType.allCases, id: \.self) { type in
              Text("\(type)")
                  .fontStyle(.title2)
              AppButton(
                  title: "Large",
                  size: .large,
                  type: type,
                  icon: .right,
                  disabled: $disabled,
                  action: {}
              )
              AppButton(
                  title: "Middle",
                  size: .middle,
                  type: type,
                  icon: .none,
                  disabled: $disabled,
                  action: {}
              )
              AppButton(
                  title: "Small",
                  size: .small,
                  type: type,
                  icon: .left,
                  disabled: $disabled,
                  action: {}
              )
              Spacer()
                  .frame(height: spacing)
          } // : FOR
          
      } // : VS
      .padding(.horizontal, padding)
  } // : SCROLL
  ```

<br>

## Font Component
> Design 에 Font Size, Pretendard, Line Height, Letter Spacing 가 정해져있고 이를 반복해서 사용해야 하는 경우에 아래와 같이 컴포넌트로 만들 수 있습니다.
- How to use
  ``` swift
  Text("title")
    .fontStyle(.title1)
    .foregroundColor(color: .textStrong)
  ```

<br>

## Color Component
> Design 에 Color 들이 정해져있고 이를 반복해서 사용해야 하는 경우에 아래와 같이 컴포넌트로 만들 수 있습니다.
- How to use SwiftUI
  ``` swift
  view
    .foregroundColor(color: .primaryNormal)
    .background(color: .primaryAlternative)
  ```
  <br>
- How to use UIKit

  ``` swift
  let messageLabel = UILabel()
  messageLabel.text = message
  messageLabel.textColor = AppColor.white.uiColor
  ```

<br>

## Log Component
> 멀티쓰레드 환경에서 Log 를 기반으로 디버깅할 때 직관적이고 작업속도가 빨랐습니다.
> 여기서 Log 에 Tag 를 붙여 원하는 Tag 의 Log 만 필터해서 볼 수 있도록 개선했습니다.

- How to use
  ``` swift
  Log.setLogLevel(LogLevel.DEBUG)
  Log.tag(.CALL).t("message")
  Log.tag(.GROUP).tag(.URI).tag(.FLOOR).e("message")
  Log.tag([.CALL, Tag.URI]).d("message")
  Log.tag([.MESSAGE, .NOTIFY]).tag(.URI).d("message")
  Log.tag(.CALL).tag([.URI, .NAME]).d("message")
  ```

<br>

- Result
  ```
  🟢 [ERROR] [FLOOR][GROUP][URI] [ContentView.swift]:22 [body]: - message
  🟢 [DEBUG] [CALL][URI] [ContentView.swift]:23 [body]: - message
  🟢 [DEBUG] [MESSAGE][NOTIFY][URI] [ContentView.swift]:24 [body]: - message
  🟢 [DEBUG] [CALL][NAME][URI] [ContentView.swift]:25 [body]: - message
  ```

<br>

## Routing
> SwiftUI 에서 가장 일반적인 예제로 Routing 하는 방식이 `Bool` 상태 변수를 통해 `isPresented` 하는 방식입니다.
> 이 방식을 채택하게 되면 `Navigation Stack` 과 관련된 모든 화면 코드에 `Bool` 상태 변수를 관리하게 됩니다.
> 이를 개선하기 위해 Routing 하기 위한 `NavigationObject` 를 개발했습니다.
> 이 방식은 iOS 16 부터 지원합니다.

- How to register
  ``` swift
  @EnvironmentObject var navigationObject: NavigationObject
  
  var body: some View {
      NavigationStack(path: $navigationObject.path) {
          VStack(spacing: spacing) {
              // add View
          }
          // routes to a view
          .navigationDestination(for: String.self) { value in
              if let navigationStackType = NavigationStackType(rawValue: value) {
                  switch navigationStackType {
                  case .dialog:
                      AppDialogPreview()
                  case .toast:
                      AppToastPreview()
                  case .button:
                      AppButtonPreview()
                  case .color:
                      AppColorPreview()
                  case .fontStyle:
                      AppFontStylePreview()
                  }
              } else {
                  ...
              }
          }
      }
  }
  ```
- How to use 
  ``` swift
  @EnvironmentObject var navigationObject: NavigationObject
  
  // push
  AppButton(title: "Push Button Stack") {
      navigationObject.push(.button)
  }
  
  // pop
  AppButton(title: "Pop Stack") {
      navigationObject.pop()
  }
  
  // popTo - UIKit 에서 popToViewController(targetVC) 의 동작과 동일하게 구현했습니다.
  AppButton(title: "Pop to Button Stack") {
      navigationObject.popTo(.button)
  }
  ```
<br>
