package blockchain

import (
	"work_queue"
)

type miningWorker struct {
	start uint64
	end uint64
	block Block
}

type MiningResult struct {
	Proof uint64 // proof-of-work value, if found.
	Found bool   // true if valid proof-of-work was found.
}

func (miner miningWorker) Run() interface{} {
	mineRes := new(MiningResult)
	block := miner.block

	for i:=miner.start; i<=miner.end; i++ {
		block.SetProof(i)
		if block.ValidHash() {
			mineRes.Proof = i
			mineRes.Found = true
			return mineRes
		}
	}
	mineRes.Found = false
	return mineRes
}

// Mine the range of proof values, by breaking up into chunks and checking
// "workers" chunks concurrently in a work queue. Should return shortly after a result
// is found.
func (blk Block) MineRange(start uint64, end uint64, workers uint64, chunks uint64) MiningResult {
	result := new(MiningResult)
	chuckSize := (end-start) / chunks
	queue := work_queue.Create(uint(workers), uint(chunks))

	startIndex := start
	for i:=uint64(0); i<chunks; i++{
		endIndex := startIndex+chuckSize
		if endIndex > end {
			endIndex = end
		}
		miner := miningWorker{startIndex, endIndex, blk}
		queue.Enqueue(miner)
		startIndex = endIndex+1
	}
	for res := range queue.Results{
		result = res.(*MiningResult)
		if result.Found {
			queue.Shutdown()
			break
		}
	}
	return *result
}

// Call .MineRange with some reasonable values that will probably find a result.
// Good enough for testing at least. Updates the block's .Proof and .Hash if successful.
func (blk *Block) Mine(workers uint64) bool {
	reasonableRangeEnd := uint64(4 * 1 << blk.Difficulty) // 4 * 2^(bits that must be zero)
	mr := blk.MineRange(0, reasonableRangeEnd, workers, 4321)
	if mr.Found {
		blk.SetProof(mr.Proof)
	}
	return mr.Found
}

