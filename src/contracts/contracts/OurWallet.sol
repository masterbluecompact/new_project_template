// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract MultiDistributable{


	struct Owner{
		uint128 portion;
		uint128 withdrawn;
	}

	mapping(address => Owner) _owners;
	address[] _addresses; // addresses of the owners
	uint256 totalReceived = 0;


	constructor(address[] memory owners, uint128[] memory portions){
		require(owners.length == portions.length, "arrays length does not match.");

		uint portionSum=0;
		for(uint i=0; i<portions.length; i++){
			portionSum += portions[i];
		}

		require(portionSum == 100, "sum of portions should be exactly 100");

		for(uint i=0 ; i<owners.length; i++){
			_addresses.push(owners[i]);
			_owners[owners[i]] = Owner(portions[i], 0);
		}
	}


	function isOwner(address owner) view public returns (bool){
		for(uint i=0 ; i<_addresses.length; i++)
			if(_addresses[i] == owner) return true;
		return false;
	}


	modifier onlyOwner(){
		require(isOwner(msg.sender));
		_;
	}


	function ownerBalance(address owner) public view returns (uint256){
		return (totalReceived) * _owners[owner].portion / 100 - (uint256)(_owners[owner].withdrawn);
	}


	function withdraw() public payable onlyOwner{
		(bool success, ) = msg.sender.call{value:ownerBalance(msg.sender)}("");
		require(success, "Transfer failed.");
	}


	function withdraw(uint256 amount) public payable onlyOwner{
		require(ownerBalance(msg.sender) >= amount, "the amount to withdraw cannot be bigger than your balance");
		(bool success, ) = msg.sender.call{value:amount}("");
		require(success, "Transfer failed.");
	}


	receive() external payable {
		totalReceived += msg.value;
	}


}