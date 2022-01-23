import UIKit
import RxSwift
import SnapKit
import RxRelay
import RxCocoa

public struct MyLibrary2 {
    public private(set) var text = "Hello, World! 111"

    public init() {
    }
}

public class MyLibraryController2: UIViewController {
    let viewModel = MyLibraryControllerViewModel()
    let myLabel = UILabel()
    let disposeBag = DisposeBag()
    @IBOutlet weak var button: UIButton!
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(myLabel)
        myLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
        }
        myLabel.text = MyLibrary2().text
        
        button.rx.tap
            .bind(to: viewModel.tappedButton)
            .disposed(by: disposeBag)
        
        viewModel.myLabelText
            .bind(to: myLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

public class MyLibraryControllerViewModel {
    let tappedButton: PublishRelay<Void> = .init()
    let myLabelText: BehaviorRelay<String> = .init(value: "")
    let disposeBag = DisposeBag()
    init() {
        tappedButton.map {
            "Hello Tap"
        }.bind(to: myLabelText)
            .disposed(by: disposeBag)
    }
    
}

public class MyLibraryStoryboard {
    public static let storyboard: UIStoryboard! = {
        UIStoryboard(name: "Storyboard", bundle: Bundle.module)
    }()
    public static let storyboardInitialVC: UIViewController = {
        storyboard.instantiateInitialViewController()!
    }()
}
