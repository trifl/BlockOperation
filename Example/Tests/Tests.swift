// https://github.com/Quick/Quick

import Quick
import Nimble
import BlockOperation

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        
        let operationQueue = NSOperationQueue()
        var blockOperation: BlockOperation!
        var value = 0
        
        describe("BlockOperation") {
            beforeEach {
                operationQueue.maxConcurrentOperationCount = 1
                blockOperation = BlockOperation(block: { blockOperation in
                    value = 1
                    blockOperation.finish()
                })
            }

            afterEach {
                value = 0
            }
            
            it("should run the block immediately") {
                operationQueue.addOperation(blockOperation)
                expect(value).toEventually(equal(1))
            }
        }
    }
}
