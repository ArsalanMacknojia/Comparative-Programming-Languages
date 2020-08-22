package blockchain

import (
	"encoding/hex"
	"github.com/stretchr/testify/assert"
	"testing"
)

// Test creating initial block
func TestInitial(t *testing.T) {
	// Setup
	b0 := Initial(16)
	// Test
	assert.Equal(t, b0.Generation, uint64(0), "Invalid initial block Generation")
	assert.Equal(t, b0.Difficulty, uint8(16), "Invalid initial block Difficulty")
	assert.Equal(t, b0.Data, "", "Invalid initial block Data")
	assert.Equal(t, b0.PrevHash, make([]byte, 32), "Invalid initial block PrevHash")
}

func TestValidatedInvalidBlock(t *testing.T){
	// Setup
	b0 := Initial(19)
	b0.SetProof(87745)
	b1 := b0.Next("hash example 1234")
	b1.SetProof(346082)
	// Test
	assert.False(t, b1.ValidHash(), "Failed to detect invalid block")
}

func TestValidateValidBlock(t *testing.T){
	// Setup
	b0 := Initial(19)
	b0.SetProof(87745)
	b1 := b0.Next("hash example 1234")
	b1.SetProof(1407891)
	// Test
	assert.True(t, b1.ValidHash(), "Failed to detect valid block")
}

func TestMining(t *testing.T){
	// Setup
	b0 := Initial(7)
	b0.Mine(1)
	b1 := b0.Next("this is an interesting message")
	b1.Mine(1)
	// Expected Values
	expectedHash0 := "379bf2fb1a558872f09442a45e300e72f00f03f2c6f4dd29971f67ea4f3d5300"
	expectedHash1 := "4a1c722d8021346fa2f440d7f0bbaa585e632f68fd20fed812fc944613b92500"
	// Test
	assert.Equal(t, hex.EncodeToString(b0.Hash), expectedHash0, "Invalid block 1 Hash")
	assert.Equal(t, hex.EncodeToString(b1.Hash), expectedHash1, "Invalid block 2 Hash")
}

func TestAddBlock(t *testing.T){
	// Setup
	blockchain := Blockchain{}
	b0 := Initial(7)
	b0.Mine(1)
	b1 := b0.Next("this is an interesting message")
	b1.Mine(1)
	// Add blocks to blockchain
	blockchain.Add(b0)
	blockchain.Add(b1)
	//Test
	assert.Equal(t, len(blockchain.Chain), 2, "Failed to add valid blocks in blockchain")
}