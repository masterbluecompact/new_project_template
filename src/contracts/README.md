# Our Wallet

OurWallet is an on-chain wallet that can be used simultaniously by many users, with limitations for each user.

## Example use cases:
- A team of freelancers.
- A purchasing department.

## Usage:
The user would create a smart contract and specify the owners of this wallet and the portions for each user, 
the address for this wallet is now the address for this group of owners.

If someone needs to send funds to the contract, they would send it just like they send to any regular wallet.

## Future improvements:
- Create more types of wallet.
- An example for a new type of a wallet:
	A portionless wallet; more gas-efficient than OurWallet, more transparent than the regular wallet.
- Implement ERC20 transfer, withdraw and claim functions.