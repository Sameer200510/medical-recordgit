// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Hospital Registration
 * @dev Store & retrieve hospital details 
 */
contract Hospital {
    // Mapping to store hospital details by hospital ID
    mapping(uint256 => hospital) public hospitallist;

    // Struct to represent a hospital
    struct hospital {
        string hospital_name;
        string hospital_address;
        string hospital_spec;
    }

    // Owner address (hospital admin)
    address public owner;

    // Constructor to set the contract owner (hospital admin)
    constructor() {
        owner = msg.sender;
    }

    // Modifier to restrict access to the contract owner (hospital admin)
    modifier isOwner() {
        require(msg.sender == owner, "Access is not allowed");
        _;
    }

    /**
     * @dev Function to store hospital details
     * @param hospital_id The hospital registration ID
     * @param _hospital_name The name of the hospital
     * @param _hospital_address The address of the hospital
     * @param _hospital_spec The specialization of the hospital
     */
    function store_hospital_details(
        uint256 hospital_id,
        string memory _hospital_name,
        string memory _hospital_address,
        string memory _hospital_spec
    ) public isOwner {
        // Create a new hospital struct and store details
        hospital memory newHospital = hospital({
            hospital_name: _hospital_name,
            hospital_address: _hospital_address,
            hospital_spec: _hospital_spec
        });

        // Store the hospital details in the mapping
        hospitallist[hospital_id] = newHospital;
    }

    /**
     * @dev Function to retrieve hospital details
     * @param hospital_id The hospital registration ID
     * @return The name, address, and specialization of the hospital
     */
    function retrieve_hospital_details(uint256 hospital_id)
        public
        view
        returns (string memory, string memory, string memory)
    {
        // Ensure that the hospital exists in the mapping
        require(bytes(hospitallist[hospital_id].hospital_name).length > 0, "Hospital not found");

        // Retrieve the hospital details from the mapping
        hospital memory h = hospitallist[hospital_id];
        return (h.hospital_name, h.hospital_address, h.hospital_spec);
    }
}
