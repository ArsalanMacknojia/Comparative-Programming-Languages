package blockchain

import "encoding/hex"

type Blockchain struct {
	Chain []Block
}

func (chain *Blockchain) Add(blk Block) {
	// You can remove the panic() here if you wish.
	if !blk.ValidHash() {
		panic("adding block with invalid hash")
	}

	if chain.IsValid(){
		chain.Chain = append(chain.Chain,  blk)
	}
}

func (chain Blockchain) IsValid() bool {
	// Check 0: Check empty chain
	if len(chain.Chain) == 0 {
		return true
	}

	// Check 1: The initial block's generation is zero and has PrevHash all null bytes.
	if chain.Chain[0].Generation != 0 {
		return false
	}
	prevHash := chain.Chain[0].PrevHash
	for i := range prevHash {
		if prevHash[i] != 0 {
			return false
		}
	}

	difficulty := chain.Chain[0].Difficulty
	generation := uint64(0)

	for i := 1; i<len(chain.Chain); i++ {
		currBlock := chain.Chain[i]
		prevBlock := chain.Chain[i-1]
		// Check 2: Each block has the same difficulty value.
		if currBlock.Difficulty != difficulty {
			return false
		}
		// Check 3: Each block has a generation value that is one more than the previous block.
		if currBlock.Generation != generation {
			return false
		}
		generation++
		// Check 4: Each block's previous hash matches the previous block's hash.
		if hex.EncodeToString(prevBlock.Hash) != hex.EncodeToString(currBlock.PrevHash) {
			return false
		}
		// Check 5: Each block's hash value actually matches its contents.
		if hex.EncodeToString(currBlock.Hash) != hex.EncodeToString(currBlock.CalcHash()){
			return false
		}
		// Check 6: Each block's hash value ends in difficulty null bits.
		if !currBlock.ValidHash(){
			return false
		}
	}
	return true
}
