package grc20

import (
	"std"
)

// userToken implements the IGRC20 interface.
//
// It is generated by userToken.GRC20().
// It can safely be explosed publicly.
type userToken struct {
	IGRC20 // implements the GRC20 interface.

	admin *AdminToken
}

// IGRC20 implementation.
//

func (t *userToken) GetName() string     { return t.admin.name }
func (t *userToken) GetSymbol() string   { return t.admin.symbol }
func (t *userToken) GetDecimals() uint   { return t.admin.decimals }
func (t *userToken) TotalSupply() uint64 { return t.admin.totalSupply }

func (t *userToken) BalanceOf(owner std.Address) (uint64, error) {
	return t.admin.balanceOf(owner)
}

func (t *userToken) Transfer(to std.Address, amount uint64) error {
	caller := std.PrevRealm().Addr()
	return t.admin.transfer(caller, to, amount)
}

func (t *userToken) Allowance(owner, spender std.Address) (uint64, error) {
	return t.admin.allowance(owner, spender)
}

func (t *userToken) Approve(spender std.Address, amount uint64) error {
	caller := std.PrevRealm().Addr()
	return t.admin.approve(caller, spender, amount)
}

func (t *userToken) TransferFrom(from, to std.Address, amount uint64) error {
	spender := std.PrevRealm().Addr()
	if err := t.admin.spendAllowance(from, spender, amount); err != nil {
		return err
	}
	return t.admin.transfer(from, to, amount)
}
