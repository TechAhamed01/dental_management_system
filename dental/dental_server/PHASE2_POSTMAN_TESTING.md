# Phase 2 Postman Testing Guide

This document outlines the standard Serverpod HTTP API contract for the Phase 2 endpoints. Since Serverpod uses a strictly defined RPC protocol over HTTP POST, you can test these endpoints without using the Dart client SDK by using Postman or cURL.

## Base URL
All API calls should be made to your Serverpod host and port. By default locally, this is:
`http://localhost:8080/`

## Headers
All requests must include the following header:
`Content-Type: application/json`

## 1. Hospital Endpoint (`/hospital`)

### Create a new Hospital
**POST** `http://localhost:8080/hospital`
```json
{
    "method": "createHospital",
    "name": "City General Hospital",
    "address": "123 Medical Way",
    "phone": "555-0100",
    "email": "contact@citygeneral.com"
}
```

### List Active Hospitals
**POST** `http://localhost:8080/hospital`
```json
{
    "method": "listActiveHospitals"
}
```

### Get a Specific Hospital
**POST** `http://localhost:8080/hospital`
```json
{
    "method": "getHospital",
    "id": 1
}
```

### Update a Hospital
*(Note: Updating a hospital requires passing the entire serialized Hospital object structure)*
**POST** `http://localhost:8080/hospital`
```json
{
    "method": "updateHospital",
    "hospital": {
        "id": 1,
        "name": "Updated City General Hospital",
        "address": "123 Medical Way",
        "phone": "555-0101",
        "email": "contact@citygeneral.com",
        "isActive": true,
        "createdAt": "2026-08-19T10:00:00.000Z"
    }
}
```

## 2. Receptionist Endpoint (`/receptionist`)

### Create a Receptionist
**POST** `http://localhost:8080/receptionist`
```json
{
    "method": "createReceptionist",
    "hospitalId": 1,
    "fullName": "Jane Doe",
    "email": "jane.doe@citygeneral.com",
    "phone": "555-0200",
    "password": "SecurePassword123!"
}
```

### Receptionist Login
**POST** `http://localhost:8080/receptionist`
```json
{
    "method": "receptionistLogin",
    "email": "jane.doe@citygeneral.com",
    "password": "SecurePassword123!"
}
```

## 3. Legacy Authentication (`/auth`)

### Legacy Dentist Registration (Without Hospital)
**POST** `http://localhost:8080/auth`
```json
{
    "method": "dentistRegister",
    "fullName": "Dr. Smith",
    "email": "smith@dental.com",
    "phone": "555-0300",
    "password": "SecurePassword123!",
    "dateOfBirth": null,
    "licenseNumber": "LIC-999888",
    "specialization": "Orthodontics",
    "qualification": "DDS",
    "experience": 10,
    "clinicName": "Smith Dental Clinic",
    "clinicAddress": "456 Dental Way",
    "profilePhotoUrl": null,
    "registrationFileUrl": null,
    "degreeFileUrl": null,
    "idFileUrl": null,
    "isTermsAccepted": true
}
```

### Legacy Admin Login
**POST** `http://localhost:8080/auth`
```json
{
    "method": "adminLogin",
    "email": "admin@dental.local",
    "password": "AdminPassword!"
}
```

### Legacy Patient Login
**POST** `http://localhost:8080/auth`
```json
{
    "method": "patientLogin",
    "email": "patient@dental.com",
    "password": "PatientPassword!"
}
```

## Advanced: Authentication Tokens
For endpoints requiring authentication (not applicable for the base Phase 2 setup, but relevant for future phases or Patient endpoints), include the `Authorization` header:
`Authorization: Bearer <your-auth-token>`
