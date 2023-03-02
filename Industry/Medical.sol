// SPDX-Licence-Verification : MIT
pragma solidity ^0.8.13;

contract Medical {
    struct Patient {
        string name;
        uint256 age;
        string[] conditions;
        string[] allergies;
        string[] medications;
        string[] procedures;
    }

    mapping(address => Patient) public patients;

    function addPatient(
        stirng memory _name,
        uint256 _age,
        string[] memory _conditions,
        string[] memory _allergies,
        string[] memory _medications,
        string[] memory _procedures
    ) public {
        Patient memory patient = Patient(
            _name,
            _age,
            _conditions,
            _allergies,
            _medications,
            _procedures
        );

        patients[msg.sender] = patient;
    }

    function updatePatient(
        string[]memory _conditions,
        string[]memory _allergies,
        string[]memory _medications,
        string[]memory _procedures,
    )public{
        Patient memory patient=patients[msg.sender];
        patient.conditions=_conditions;
        patient.allergies=_allergies;
        patient.medications=_medications;
        patient.procedures=_procedures;
    }

    function getPatient(address _patientAddress) public view returns(
        string memory,
        uint256,
        string[]memory,
        string[]memory,
        string[]memory,
        string[]memory
        ){
            Patient memory patient=patients[_patientAddress];

            return (patient.name,
            patient.age,
            patient.conditions,
            patient.allergies,
            patient.medications,
            patient.procedures);
        }
}
