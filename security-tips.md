## Preventing certain types of attacks
- Reentry Attacks
    <p>This attack consists on recursively calling the call.value() method in a ERC20 token to extract the ether stored on the contract if the user is not updating the balance of the sender before sending the ether.</p>
    <p>Use `transfer()` instead of `call.value()`</p>
- Over and Under flows
    <p>An overflow happens when the limit of the type varibale uint256 , 2**256, is exceeded. What happens is that the value resets to zero instead of incrementing more.</p>
    <p>To avoid unsafe calculations, use OpenZeppelin's <code>SafeMath.sol</code> Library</p>
- Reordering Attack
    <p>This attack consists in that a miner or other party tries to “race” with a smart contract participant by inserting their own information into a list or mapping so the attacker may be lucky in getting their own information stored on the contract.</p>
    <p>update and finalize all conditions prior to payable functions</p>
- Short Address Attack
    <p>When The server taking in user data allows an Ethereum address that was less than 20 bytes: usually an Ethereum address looks like 0x1234567890123456789012345678901234567800. if you remove the trailing zerous it will still go through and actually take multiply amount wanted by 256 or 2^8</p>
    <p>Check for address inputs to be 20 bytes long</p>
    <p>Check for require(len(msg.data) == 68) or assert(len(msg.data) == 68) to be the right size 68 bytes</p>
- `require()` vs `assert()`
    <p>`require()` is normally used at the top of the functions to verify the input of the function</p>
    <p>`assert()` is used to validate contract state after making changes</p>
- Don't use pragma soldiity^0.4.18, instead use pragma solidity 0.4.18
    <p>This is not a good practice since there could be major changes between versions that would make your code unstable. That’s why I recommend to set a fixed version without the caret like 0.4.18</p>
