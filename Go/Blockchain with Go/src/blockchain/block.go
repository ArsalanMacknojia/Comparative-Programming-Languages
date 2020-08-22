package blockchain

import (
	"crypto/sha256"
	"encoding/hex"
	"strconv"
	"strings"
)

type Block struct {
	PrevHash   []byte
	Generation uint64
	Difficulty uint8
	Data       string
	Proof      uint64
	Hash       []byte
}

// Create new initial (generation 0) block.
func Initial(difficulty uint8) Block {
	// Previous hash of 32 zero bytes ("\x00")
	prevHash := make([]byte, 32)
	// Creating initial block (generation 0)
	initialBlock := Block{
		PrevHash: prevHash,
		Generation: 0,
		Difficulty: difficulty,
		Data: "",
	}
	return initialBlock
}

// Create new block to follow this block, with provided data.
func (prev_block Block) Next(data string) Block {
	nextBlock := Block{
		PrevHash: prev_block.Hash,
		Generation: prev_block.Generation + 1,
		Difficulty: prev_block.Difficulty,
		Data: data,
	}
	return nextBlock
}

// Calculate the block's hash.
func (blk Block) CalcHash() []byte {
	blockContent := strings.Join([]string{
		hex.EncodeToString(blk.PrevHash),
		strconv.Itoa(int(blk.Generation)),
		strconv.Itoa(int(blk.Difficulty)),
		blk.Data,
		strconv.Itoa(int(blk.Proof)),
	}, ":")

	hash := sha256.New()
	hash.Write([]byte(blockContent))
	return hash.Sum(nil)
}

//Is this block's hash valid?
func (blk Block) ValidHash() bool {
	blockHash := blk.Hash
	hashLen := len(blockHash)

	difficulty := blk.Difficulty
	nBytes := int(difficulty/8)
	nBits := difficulty%8

	// Check 1: Hash exist
	if hashLen<=0 {
		return false
	}
	// Check 2: Last nBytes bytes are '\x00'.
	for i:= hashLen-nBytes; i<hashLen; i++{
		if blockHash[i] != '\x00'{
			return false
		}
	}
	// Check 3: Next byte from the end is divisible by 2^nBits
	if (blockHash[hashLen-nBytes-1] % (1<<nBits)) !=0 {
		return false
	}

	return true
}

// Set the proof-of-work and calculate the block's "true" hash.
func (blk *Block) SetProof(proof uint64) {
	blk.Proof = proof
	blk.Hash = blk.CalcHash()
}


