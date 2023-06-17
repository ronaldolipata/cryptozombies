pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {
    event NewZombie(uint zombieId, string name, uint dna);

    // Set zombie dna to 16-digit number
    uint dnaDigits = 16;

    // Set modulus and use it later to make sure the dna is only 16 characters
    uint dnaModulus = 10 ** dnaDigits;

    // Struct for zombie to have multiple properties
    struct Zombie {
        string name;
        uint dna;
    }

    // Public array to store the zombie
    Zombie[] public zombies;

    // Function that accepts name and dna to create zombies
    function _createZombie(string memory _name, uint _dna) private {
        // Push the zombie to the array and get the last index of the array, then assign it to the id
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        // Emit the NewZombie to reference 
        emit NewZombie(id, _name, _dna);
    }

    // Function that accepts string to generate random dna for the zombie
    function _generateRandomDna(string memory _str) private view returns (uint) {
        // Use keccack256 hash function to create number data and assign it to rand
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        // Return the reminder to make sure the dna is only 16-digit character
        return rand % dnaModulus;
    }

    // Function that accepts a name to a create random zombie
    function createRandomZombie(string memory _name) public {
        // Generate random dna by calling the function of _generateRandomDna and assign to randDna
        uint randDna = _generateRandomDna(_name);
        // Call the _createZombie function and pass the name and random dna to create a zombie
        _createZombie(_name, randDna);
    }
}
