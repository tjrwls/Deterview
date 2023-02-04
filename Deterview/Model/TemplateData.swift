//
//  TemplateData.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import Foundation

class TemplateData: QuestionFolderStore {
    
    let frontEndQuestions: [String] = ["브라우저의 동작 원리를 간단하게 설명해 주세요.",
    "CORS가 무엇이며 어떻게 해결을 할 수 있는지 설명해 주세요.",
     "크로스 브라우징이 무엇인가요?",
    "서버 사이드 렌더링과 클라이언트 사이드 렌더링의 차이에 대해 설명해 주세요.",
    "쿠키와 세션 스토리지, 로컬 스토리지의 차이를 설명해 주세요.",
    "Progressive Rendering이 무엇인가요?",
    "SEO는 무엇인가요?",
    "<section>과 <article>의 차이는 무엇인가요?",
    "HTML5 tag를 설명해 주세요.",
     "시멘틱 태그에 대해서 설명해 주세요.",
    "Reflow와 Repaint가 실행되는 시점에 대해 설명해 주세요.",
    "주소창에 google.com을 입력하면 일어나는 일에 대해 설명해 주세요.",
    "호이스팅에 대해서 설명해 주세요.",
    "클로저에 대해서 설명해 주세요.",
    "CSS에서 margin과 padding에 대해서 설명해 주세요.",
    "CSS에서 position을 어떻게 사용하는지 설명해 주세요.",
    "REST API란 무엇인지 설명해 주세요.",
    "this는 JavaScript에서 어떻게 작동하는지 설명해 주세요.",
    "브라우저 저장소의 차이점에 대해 설명해 주세요.",
    "Restful API에 대해 아는대로 설명해 주세요.",
    "JavaScript에서 비동기적으로 코딩하는 법을 설명해 주세요.",
    "SPA, CSR, SSR의 차이에 대해 설명해 주세요.",
    "class와 id의 차이점을 설명해 주세요.",
    "float가 어떻게 동작하나요?",
    "클리어링(Clearing)에는 어떤 것들이 있으며, 각각은 어떨 때 사용하는지 설명해 주세요.",
    "padding과 margin의 차이가 무엇인가요?",
    "CSS 전처리기의 장점과 단점은 무엇인가요?",
    "CSS selector가 어떠한 원리로 동작하는지 설명해 주세요.",
    "display 속성에 어떤 것들이 있는지 설명해 주세요.",
    "요소를 배치하는 방법(static, relative, fixed, absolute) 간의 차이는 무엇인가요?",
    "CSS 애니메이션과 JS 애니메이션의 차이에 대해서 설명해 주세요.",
    "prototype 기반 상속은 어떻게 하는지 설명해 주세요.",
    "null과 undefined의 차이점은 무엇인가요?",
     "async/await의 차이점에 대해서 설명해 주세요.",
    "let, var, const의 차이점에 관해서 설명해 주세요.",
    "Javascript Scope Chaining에 대해 설명해 주세요.",
    "use strict 은 무엇이고, 사용했을 때 장단점에 관해서 설명해 주세요.",
    "JSON이 무엇이며 사용하면 어떠한 장점이 있는지 설명해 주세요.",
    "함수형 프로그래밍에 대해 설명해 주세요.",
    "Callback을 왜 사용하는지 설명해 주세요.",
    "모듈 패턴과 전통적 상속, 각각의 장단점을 설명해 주세요."]

    let iosQuesitons: [String] = ["Bounds와 Frame의 차이점을 설명해 주세요.",
    "상태 변화에 따라 다른 동작을 처리하기 위한 앱델리게이트 메서드들을 설명해 주세요.",
    "GCD API 동작 방식과 필요성에 대해 설명해 주세요.",
    "TableView를 동작 방식과 화면에 Cell을 출력하기 위해 최소한 구현해야 하는 DataSource 메서드를 설명해 주세요.",
    "Global DispatchQueue 의 Qos 에는 어떤 종류가 있는지, 각각 어떤 의미인지 설명해 주세요.",
    "iOS 앱을 만들고, User Interface를 구성하는 데 필수적인 프레임워크 이름은 무엇인가요?",
    "Foundation Kit은 무엇이고 포함되어 있는 클래스들은 어떤 것이 있는지 설명해 주세요.",
    "Delegate란 무엇인지 설명하고, retain 되는지 안되는지 그 이유를 함께 설명해 주세요.",
    "모든 View Controller 객체의 상위 클래스는 무엇이고 그 역할은 무엇인가요?",
    "자신만의 Custom View를 만들려면 어떻게 해야하는지 설명해 주세요.",
    "UIView 에서 Layer 객체는 무엇이고 어떤 역할을 담당하는지 설명해 주세요.",
    "UIWindow 객체의 역할은 무엇인가요?",
    "UINavigationController 의 역할이 무엇인지 설명해 주세요.",
    "NSCache와 딕셔너리로 캐시를 구성했을때의 차이를 설명해 주세요.",
    "URLSession에 대해서 설명해 주세요.",
    "오토레이아웃을 코드로 작성하는 방법은 무엇인가요? (3가지)",
    "스토리보드를 이용했을때의 장단점을 설명해 주세요.",
    "struct와 class의 차이를 설명해 주세요.",
    "Optional 이란 무엇인지 설명해 주세요.",
    "Delegate 패턴을 활용하는 경우를 예를 들어 설명해 주세요.",
    "Singleton 패턴을 활용하는 경우를 예를 들어 설명해 주세요.",
    "Hashable이 무엇이고, Equatable을 왜 상속해야 하는지 설명해 주세요.",
    "mutating 키워드에 대해 설명해 주세요.",
    "접근 제어자의 종류엔 어떤게 있는지 설명해 주세요.",
    "defer란 무엇인지 설명하고, 호출되는 순서와 defer가 호출되지 않는 경우를 설명해 주세요.",
    "ARC란 무엇인지 설명해 주세요.",
    "Strong 과 Weak 참조 방식에 대해 설명해 주세요.",
    "순환 참조에 대하여 설명해 주세요.",
    "강한 순환 참조 (Strong Reference Cycle) 는 어떤 경우에 발생하는지 설명해 주세요.",
    "고차 함수가 무엇인지 설명해 주세요.",
    "Swift Standard Library의 map, filter, reduce, compactMap, flatMap에 대하여 설명해 주세요.",
    "MVVM, MVI, Ribs, VIP 등 자신이 알고있는 아키텍쳐를 설명해 주세요.",
    "의존성 주입에 대하여 설명해 주세요.",
    "@State에 대해서 설명해 주세요.",
    "@Published에 대해서 설명해 주세요.",
    "throttle과 debounce의 차이점을 설명해 주세요.",
    "Reactive Programming이 무엇인지 설명해 주세요.",
    "RxSwift를 왜 사용하는지 설명해 주세요.",
    "RxSwift에서 Hot Observable과 Cold Observable의 차이를 설명해 주세요.",
    "Single, Completable, Maybe의 차이점에 대해 설명하고, 언제 적용하면 좋을지 설명해 주세요."
     ]

    let csQuestion: [String] = [
    "객체 지향 프로그래밍이란 무엇인가요?",
    "함수형 프로그래밍이란 무엇인가요?",
    "프로토콜 지향 프로그래밍이란 무엇인가요?",
    "RESTFul API란 무엇인가요?",
    "TDD(Test-Driven Development)란 무엇인가요?",
    "API(Application Programming Interface)란 무엇인가요?",
    "프레임워크와 라이브러리의 차이는 무엇인가요?",
    "Git과 GitHub란 무엇인가요?",
    "MVC패턴이란 무엇인가요?",
    "MVVM패턴이란 무엇인가요?",
    "디자인 패턴이란 무엇인가요?",
    "Array와 Linked List의 차이점은 무엇인가요?",
    "Stack과 Queue의 차이점은 무엇인가요?",
    "Heap이란 무엇인가요?",
    "Tree이란 무엇인가요?",
    "Binary Search Tree란 무엇인가요?",
    "Hash Table이란 무엇인가요?",
    "B Tree & B+ Tree에 대해서 설명해주세요.",
    "DBMS란 무엇인가요?",
    "UML이란 무엇인가요?",
    "트랜잭션이란 무엇인가요?",
    "DataBase에서 인덱스란 무엇인가요?",
    "정규화에 대해서 설명해주세요.",
    "SQL에 대해서 설명해주세요.",
    "NoSQL에 대해서 설명해주세요.",
    "OSI 7계층에 대해서 설명해주세요.",
    "HTTP와 HTTPS의 차이점은 무엇인가요?",
    "HTTP의 문제점에 대해서 설명해주세요.",
    "TCP와 UDP의 차이점의 차이점은 무엇인가요?",
    "쿠키와 세션의 차이점은 무엇인가요?",
    "GET과 POST의 차이점은 무엇인가요?",
    "운영체제란 무엇인가요?",
    "프로세스와 스레드의 차이는?",
    "멀티 스레드의 단점과 장점은?",
    "스케줄러란 무엇인가요?",
    "CPU 스케줄링 기법에는 무엇이 있나요?",
    "데드락에 대해서 설명해주세요",
    "동기와 비동기의 차이는 무엇인가요?",
    "메모리에 대해서 설명해주세요."]

    let androidQuestion: [String] = [
    "Activity란 무엇인가요?",
    "Service란 무엇인가요?",
    "BroadCast Receiver란 무엇인가요?",
    "Content Provider란 무엇인가요?",
    "Intent에 관한 설명해주세요.",
    "Activity, Fragment의 차이점은 무엇인가요?",
    "Activity, Fragment의 생명주기에 대해서 설명해주세요.",
    "ListView과 RecyclerView 차이점에 대해 설명해주세요.",
    "DiffUtil이란 무엇인가요??",
    "Reflection이란 무엇인가요?",
    "OOM(Out Of Memory)에 대해서 설명해주세요.",
    "LMK(Low Memory Killer)에 대해서 설명해주세요.",
    "ANR이란 무엇인가요?",
    "Annotation이란 무엇인가요?",
    "Context란 무엇인가요?",
    "Inflate란 무엇인가요?",
    "Dependency Injection이란 무엇인가요?",
    "Koin vs Dagger 비교해서 대해서 설명해주세요.",
    "SharedPreferences란 무엇인가요?",
    "Image Loading 라이브러리에 대해서 설명해주세요.",
    "직렬화 vs 역직렬화에 대해서 설명해주세요.",
    "Java vs Kotlin에 대해서 설명해주세요.",
    "RxJava에서 map, flatMap의 차이점을 설명해주세요.",
    "Immutable이란 무엇일까요?",
    "Android enum을 자제시키는 이유는 무엇일까요?",
    "Android Process와 Thread에 대한 설명해주세요."
    ]

    func createdTemplateData() {
        let questionFolders: [(String, [String])] = [("CS", csQuestion), ("iOS", iosQuesitons), ("AOS", androidQuestion), ("Front-End", frontEndQuestions)]
        for folder in questionFolders {
            let questionFolder: QuestionFolder = QuestionFolder()
            questionFolder.folderName = folder.0
            questionFolder.category = "Main"
            questionFolder.id = UUID().uuidString
            
            try? self.realm.write {
                self.realm.add(questionFolder)
            }
            
            for question in folder.1 {
                let newQuestion = Question()
                newQuestion.question = question
                newQuestion.id = UUID().uuidString
                try? realm.write {
                    questionFolder.questionList.append(newQuestion)
                }
            }
        }
    }
}
