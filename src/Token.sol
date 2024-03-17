// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Token {
    string public name;
    string public symbol;
    /*Como o Float é dificil de trabalhar, indicamos como o token será lido
    ex: 2 decimais:
    100098 = 100,98
    */
    uint8 public decimals;
    uint256 public totalSupply;

    event Transfer(address from, address to, uint256 amount);
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 amount
    );

    mapping(address => uint256) balances;
    /**
    | adress | amount               |
    |contrato|total da conta        |
     */

    // lista quanto eu deixo um contrato gastar do meu dinheiro
    mapping(address => mapping(address => uint256)) allowances;

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public {
        //Se o amount do emissário for maior, continua. Se não, mostra o erro
        require(balances[msg.sender] >= _value, "INSUFFICIENT_AMOUNT");

        balances[_to] += _value;
        balances[msg.sender] -= _value;

        emit Transfer(msg.sender, _to, _value);
    }

    //
    function approve(address _spender, uint256 _value) public {
        allowances[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value);
    }

    function transferFrom(address _from, address _to, uint256 _value) public {
        require(allowances[_from][msg.sender] >= _value, "INSUFFICIENT_AMOUNT");

        //from é o contrato alvo que deixa o msg.sender enviar o dinheiro
        balances[_from] -= _value;
        balances[_to] += _value;
    }

    function allowance(
        address _owner,
        address _spender
    ) public view returns (uint256 remaining) {
        return allowances[_owner][_spender];
    }

    constructor() {
        name = "NearX Innovation School";
        symbol = "NRX";
        decimals = 18;

        totalSupply = 10000 * 10e18;
        //cria o token
        balances[msg.sender] = totalSupply;
    }
}
