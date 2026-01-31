# API Examples for Business Central

A Business Central AL example extension that provides guidance on how to implement custom API pages for use with BCPortal.Cloud. If you wish to use this extension please make sure to generate a **new** GUID for the App ID.

## Overview

This extension demonstrates how to create custom API pages for BCPortal.Cloud in Business Central. It includes examples of exposing data through REST APIs that can be consumed by our portal solution.

## Features

- **Items API**: Exposes Item data through a custom API endpoint
  - Endpoint: `/api/slokSoftware/bcPortal/v2.0/items`
  - Read-only access to item information including:
    - Item number
    - Description
    - Country/Region of Origin
    - Unit Price
    - Inventory levels
    - Sales Unit of Measure

## Requirements

- Business Central version 27.0 or higher
- Runtime 16.0

## Installation

1. Download the latest `.app` file from the releases
2. Install the extension in your Business Central environment using the Extension Management page
3. The API endpoints will be automatically available

## API Usage

### Items Endpoint

**GET** `/api/slokSoftware/BcPortal/v2.0/items`

Returns a list of items with the following fields:
- `id`: System ID (GUID)
- `number`: Item number
- `description`: Item description
- `countryRegionOfOriginCode`: Country/Region of origin
- `unitPrice`: Unit price
- `inventory`: Current inventory level
- `salesUnitOfMeasure`: Sales unit of measure

### Example Request

```http
GET https://your-bc-instance.com/api/slokSoftware/BcPortal/v2.0/items
Authorization: Bearer {your-token}
```

### Example Response

```json
{
  "value": [
    {
      "id": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "number": "1000",
      "description": "Sample Item",
      "countryRegionOfOriginCode": "US",
      "unitPrice": 10.50,
      "inventory": 100,
      "salesUnitOfMeasure": "PCS"
    }
  ]
}
```

## Development

### Project Structure

```
.
├── app.json                          # Extension manifest
├── src/
│   └── API/
│       └── Items.Page.al            # Items API page
└── README.md
```

### Building the Extension

1. Open the workspace in Visual Studio Code with AL Language extension
2. Press `Ctrl+Shift+B` (or `Cmd+Shift+B` on Mac) to build
3. The `.app` file will be generated

## Support

For support and more information, visit [BCPortal.Cloud](https://www.slok.com/bcportal)

## License

© Slok Software

## Version History

### 1.0.0.0
- Initial release
- Items API endpoint
