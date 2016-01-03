public class BlockOperation: NSOperation {
    private var _executing = false
    public override var executing : Bool {
        get {
            return _executing
        }
        set {
            willChangeValueForKey("isExecuting")
            _executing = newValue
            didChangeValueForKey("isExecuting")
        }
    }
    
    private var _finished = false
    public override var finished : Bool {
        get {
            return _finished
        }
        set {
            willChangeValueForKey("isFinished")
            _finished = newValue
            didChangeValueForKey("isFinished")
        }
    }
    
    public override var concurrent: Bool {
        get {
            return true
        }
    }
    
    public let block: (blockOperation: BlockOperation) -> ()
    public init(block: (blockOperation: BlockOperation) -> ()) {
        self.block = block
    }
    
    public override func start() {
        executing = true
        dispatch_async(dispatch_get_main_queue()) {
            self.block(blockOperation: self)
        }
    }
    
    public func finish() {
        executing = false
        finished = true
    }
}