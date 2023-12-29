import UIKit

class CollisionExampleViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var animator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    var collisionBehavior: UICollisionBehavior!
    var mainCarView: UIView!
    var timerEdge = Timer()
    var timerCar = Timer()
    var timerObstacle = Timer()
    var scoreTimer = Timer()
    
    var stationarView = GameView()
    var currentResult = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        stationarView.stopButton.addTarget(self, action: #selector(stopButton), for: .touchUpInside)
    }
    override func viewWillAppear(_ animated: Bool) {
        addGameView()
        currentResult = 0
        setupAnimationBehavior()
        navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        cleanScreen()
    }
    func cleanScreen(){
        animator.removeAllBehaviors()
        for newView in self.view.subviews{
            newView.removeFromSuperview()
            gravityBehavior.removeItem(newView)
        }
    }
    private func addGameView() {
        stationarView = GameView()
            view.addSubview(stationarView)
        stationarView.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.left.right.equalToSuperview()
            make.height.equalToSuperview()
            }
        stationarView.stopButton.addTarget(self, action: #selector(stopButton), for: .touchUpInside)
        stationarView.layer.zPosition = 1
        }
    private func setupAnimationBehavior(){
        view.setNeedsDisplay()
        animator = UIDynamicAnimator(referenceView: view)
        collisionBehavior = UICollisionBehavior(items: [])
        collisionBehavior.collisionDelegate = self
        animator.addBehavior(collisionBehavior)
        gravityBehavior = UIGravityBehavior(items: [])
        gravityBehavior.magnitude = 0.3
        animator.addBehavior(gravityBehavior)
        setupMainCar()
        dropCarRepating()
        dropEdgeRepating()
        dropCenterRepating()
        dropObstacleRepating()
        startScoreCalculation()
    }

    //MARK: MainCarSetuping
    private func setupMainCar() {
        mainCarView = UIView(frame: CGRect(x: GameConstants.share.carStartCoodinates.0,
                                           y: GameConstants.share.carStartCoodinates.1,
                                           width: GameConstants.share.carSizes.0,
                                           height: GameConstants.share.carSizes.1))
        mainCarView.backgroundColor = GameSettings.shared.currentColor
        view.addSubview(mainCarView)
        collisionBehavior.addItem(mainCarView)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        mainCarView.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        mainCarView.addGestureRecognizer(swipeLeft)
    }
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .right:
            mainCarView.center.x += GameConstants.share.distanseToMove
        case .left:
            mainCarView.center.x -= GameConstants.share.distanseToMove
        default:
            break
        }
        animator.updateItem(usingCurrentState: mainCarView)
    }
    @objc func stopButton(){
        stopGame()
    }
    //MARK: Obstacle&RoadSign Setuping
    private func dropCarViewFromTop() {
        let x1 = UIScreen.main.bounds.width * 0.5 + UIScreen.main.bounds.width / 4 * 0.2
        let x2 = UIScreen.main.bounds.width * 0.25  + UIScreen.main.bounds.width / 4 * 0.2
        let startX = [x1, x2].randomElement() ?? UIScreen.main.bounds.midX
        // Создаем view, которые будут падать сверху
        let dropView = UIView(frame: CGRect(
            x: startX,
            y: CGFloat.random(in: -1000 ... -100),
            width: GameConstants.share.carSizes.0,
            height: GameConstants.share.carSizes.1))
        dropView.backgroundColor = .white
        view.addSubview(dropView)
        gravityBehavior.addItem(dropView)
        collisionBehavior.addItem(dropView)
    }
    private func dropCarRepating(){
        timerCar = Timer.scheduledTimer(withTimeInterval: GameSettings.shared.gameLevel, repeats: true) { [weak self] timer in
            self?.dropCarViewFromTop()
        }
    }
    private func dropRoadEdge() {
        let leftBorder = UIView(frame: CGRect(
            x: GameConstants.share.leftRoadEdgeCoordinate.0,
            y: GameConstants.share.leftRoadEdgeCoordinate.1,
            width: GameConstants.share.roadEdgesSizes.1,
            height: GameConstants.share.roadEdgesSizes.0))
        let rightBorder = UIView(frame: CGRect(
            x: GameConstants.share.rightRoadEdgeCoordinate.0,
            y: GameConstants.share.leftRoadEdgeCoordinate.1,
            width: GameConstants.share.roadEdgesSizes.1,
            height: GameConstants.share.roadEdgesSizes.0))
        
        view.addSubview(leftBorder)
        view.addSubview(rightBorder)
        
        leftBorder.backgroundColor = .white
        rightBorder.backgroundColor = .white
        
        gravityBehavior.addItem(leftBorder)
        gravityBehavior.addItem(rightBorder)
    }
    private func dropEdgeRepating(){
        Timer.scheduledTimer(withTimeInterval: GameSettings.shared.gameLevel / 3, repeats: true) { [weak self] timer in
            self?.dropRoadEdge()
        }
    }
    private func dropCenterRoad(){
        let centrRoad = UIView(frame: CGRect(
            x: GameConstants.share.centerX,
            y: GameConstants.share.leftRoadEdgeCoordinate.1,
            width: GameConstants.share.roadEdgesSizes.1,
            height: GameConstants.share.centerRoadH))
        view.addSubview(centrRoad)
        centrRoad.backgroundColor = .white
        gravityBehavior.addItem(centrRoad)
    }
    private func dropCenterRepating(){
        timerEdge = Timer.scheduledTimer(withTimeInterval: GameSettings.shared.gameLevel / 10, repeats: true) { [weak self] timer in
            self?.dropCenterRoad()
        }
    }
    private func dropObstacles() {
        let leftO = UIView(frame: CGRect(
            x: GameConstants.share.leftTreesEdgeCoordinate.0,
            y: CGFloat.random(in: -1000 ... GameConstants.share.leftTreesEdgeCoordinate.1) ,
            width: GameConstants.share.treesSizes,
            height: GameConstants.share.treesSizes))
        let rightO = UIView(frame: CGRect(
            x: GameConstants.share.rightTreesEdgeCoordinate.0,
            y: CGFloat.random(in: -1000 ... GameConstants.share.leftTreesEdgeCoordinate.1) ,
            width: GameConstants.share.treesSizes,
            height: GameConstants.share.treesSizes))
        view.addSubview(leftO)
        view.addSubview(rightO)
    
        leftO.backgroundColor = .white
        rightO.backgroundColor = .white
        gravityBehavior.addItem(leftO)
        gravityBehavior.addItem(rightO)
        collisionBehavior.addItem(leftO)
        collisionBehavior.addItem(rightO)
    }
    private func dropObstacleRepating(){
        timerObstacle = Timer.scheduledTimer(withTimeInterval: GameSettings.shared.gameLevel * 2, repeats: true) { [weak self] timer in
            self?.dropObstacles()
        }
    }
    private func startScoreCalculation(){
        scoreTimer = Timer.scheduledTimer(withTimeInterval: GameSettings.shared.gameLevel / 2, repeats: true, block: { [weak self] timer in
            self?.currentResult += 1
            self?.stationarView.scoreLabel.text = String("Score: \(self?.currentResult ?? 0)")
        })
    }
    private func makeRecords(){
        let currentBestResult = player.shared.playersDictionary[GameSettings.shared.currentUser] ?? 0
        let newResult = currentResult
        if newResult > currentBestResult {
            player.shared.playersDictionary[GameSettings.shared.currentUser] = newResult
            memoryServices.shared.updateResultsInformation()
        }
    }
}
// MARK: UICollisionBehaviorDelegate
extension CollisionExampleViewController {
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        if (item1 === mainCarView && item2 !== mainCarView) ||
            (item2 === mainCarView && item1 !== mainCarView) {
            gravityBehavior.magnitude = 0
            mainCarView.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.stopGame()
            }
        }
    }
    private func stopGame(){
        makeRecords()
        cleanScreen()
        timerEdge.invalidate()
        timerObstacle.invalidate()
        timerCar.invalidate()
        scoreTimer.invalidate()
        navigationController?.popViewController(animated: true)
    }

}
